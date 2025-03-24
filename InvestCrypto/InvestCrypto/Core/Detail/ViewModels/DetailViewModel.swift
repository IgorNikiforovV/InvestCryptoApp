//
//  DetailViewModel.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 03.03.2025.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {

    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String?
    @Published var redditURL: String?
    @Published var websiteURL: String?

    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrys in
                self?.overviewStatistics = returnedArrys.overview
                self?.additionalStatistics = returnedArrys.additional
            }
            .store(in: &cancellables)

        coinDetailService.$coinDetails
            .sink{ [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.description?.en
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
}

extension DetailViewModel {
    private func mapDataToStatistics(
        coinDetailModel: CoinDetailModel?,
        coinModel: CoinModel
    ) -> (overview: [StatisticModel], additional: [StatisticModel])
    {
        // overview
        let overviewArray = overviewArray(coinModel: coinModel)
        // additional
        let additionalArray = additionalArray(
            coinDetailModel: coinDetailModel,
            coinModel: coinModel
        )

        return (overviewArray, additionalArray)
    }

    private func overviewArray(
        coinModel: CoinModel
    ) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)

        let marketCap = "$" + (coinModel.marketCap?.formettedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)

        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)

        let volume = "$" + (coinModel.totalVolume?.formettedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)

        return [priceStat, marketCapStat, rankStat, volumeStat]
    }

    private func additionalArray(
        coinDetailModel: CoinDetailModel?,
        coinModel: CoinModel
    ) -> [StatisticModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)

        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)

        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)

        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formettedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let maketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)

        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)

        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algoritm", value: hashing)

        return [ highStat, lowStat, priceChangeStat, maketCapChangeStat, blockStat, hashingStat]
    }
}
