//
//  HomeViewModel.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 03.02.2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    var statistics: [StatisticModel] = []

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var sortOption: SortOption = .holdings

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()

    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }

    init() {
        addSubscribers()
    }

    func addSubscribers() {
//        dataService.$allCoins
//            .sink { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)

        // updates all coins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)

        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map (mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self else { return }
                portfolioCoins = sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)

        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }

    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }

    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }

    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort  (by: { $0.currentPrice < $1.currentPrice })
        }
    }

    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will only sort by holdings or reversedHoldings if needed
        switch sortOption {
        case .holdings:
            coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            coins
        }
    }

    private func filterAndSortCoins(
        text: String,
        coins: [CoinModel],
        sort: SortOption
    ) -> [CoinModel]  {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }

    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }

        let lowercasedText = text.lowercased()
        return coins.filter {
            $0.name.lowercased().contains(lowercasedText) ||
            $0.symbol.lowercased().contains(lowercasedText) ||
            $0.id.lowercased().contains(lowercasedText)
        }
    }

    private func mapAllCoinsToPortfolioCoins(
        allCoins: [CoinModel],
        portfolioCoins: [PortfolioEntity]
    ) -> [CoinModel] {
        allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioCoins.first(where: {
                coin.id == $0.coinID
            }) else { return nil }
            return coin.updateHoldings(amount: entity.amount )
        }
    }

    private func mapGlobalMarketData(
        _ marketDataModel: MarketDataModel?,
        portfolioCoins: [CoinModel]
    ) -> [StatisticModel] {
        guard let data = marketDataModel else { return [] }

        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: "$0.00", percentageChange: 0)

        let portfolioValue = portfolioCoins.map { $0.currentHoldingsValue }.reduce(0, +)
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
        .reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue )

        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange
        )

        return [marketCap, volume, btcDominance, portfolio]
    }
}
