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

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()

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
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)

        marketDataService.$marketData.map { MarketDataModel -> [StatisticModel] in
            guard let data = MarketDataModel else { return [] }

            let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = StatisticModel(title: "24h Volume", value: data.volume)
            let btcDominance = StatisticModel(title: "BTC Dominance", value: "$0.00", percentageChange: 0)
            let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
            return [marketCap, volume, btcDominance, portfolio]
        }
        .sink { [weak self] returnedStats in
            self?.statistics = returnedStats
        }
        .store(in: &cancellables)
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
}
