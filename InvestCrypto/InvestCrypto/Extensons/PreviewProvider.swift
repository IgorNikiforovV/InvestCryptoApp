//
//  PreviewProvider.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 31.01.2025.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

extension Preview {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }

    let homeVM = HomeViewModel()

    let stste1 = StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
    let stste2 = StatisticModel(title: "Total Volume", value: "$1.23Tr")
    let stste3 = StatisticModel(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)

    let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 70187,
        marketCap: 1381651251183,
        marketCapRank: 1,
        fullyDilutedValuation: 1474623675796,
        totalVolume: 20154184933,
        high24H: 70215,
        low24H: 68060,
        priceChange24H: 2126.88,
        priceChangePercentage24H: 3.12502,
        marketCapChange24H: 44287678051,
        marketCapChangePercentage24H: 3.31157,
        circulatingSupply: 19675987,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 73738,
        athChangePercentage: -4.77063,
        athDate: "2024-03-14T07:10:36.635Z",
        atl: 67.81,
        atlChangePercentage: 103455.83335,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: nil,
        currentHoldings: 1.5
    )
}
