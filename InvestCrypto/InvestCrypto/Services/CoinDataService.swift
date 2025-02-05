//
//  CoinDataService.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 04.02.2025.
//

import Foundation
import Combine

// MARK: Nested types

extension CoinDataService {
    private enum Const {
        static let currency = (name: "vs_currency", value: "usd")
        static let page = (name: "page", value: "1")
        static let perPage = (name: "per_page", value: "50")
        static let sparkline = (name: "sparkline", value: "true")
        static let percentage24 = (name: "price_change_percentage", value: "24h")
        static let method = "GET"
        static let accept = (name: "accept", value: "application/json")
        static let key = (name: "x-cg-demo-api-key", value: "CG-RspF9kDAPWeqfA2hEMgQcDYF")
    }
}

final class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    private var coinSubscription: AnyCancellable?

    private let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!

    init() {
        getCoins()
    }

    private func getCoins() {
        coinSubscription = NetworkingManager.send(with: urlRequest)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }

    private var urlRequest: URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: Const.currency.name, value: Const.currency.value),
            URLQueryItem(name: Const.perPage.name, value: Const.perPage.value),
            URLQueryItem(name: Const.page.name, value: Const.page.value),
            URLQueryItem(name: Const.sparkline.name, value: Const.sparkline.value),
            URLQueryItem(name: Const.percentage24.name, value: Const.percentage24.value),
        ]

        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = Const.method
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            Const.accept.name: Const.accept.value,
            Const.key.name: Const.key.value
        ]

        return request
    }
}

extension CoinDataService {
    static let jsonData = """
    [
    {
    "id": "ethereum",
    "symbol": "eth",
    "name": "Ethereum",
    "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
    "current_price": 2722.79,
    "market_cap": 328391725387,
    "market_cap_rank": 2,
    "fully_diluted_valuation": 328391725387,
    "total_volume": 62820085504,
    "high_24h": 102614,
    "low_24h": 94152,
    "price_change_24h": 178.24,
    "price_change_percentage_24h": 7.00476,
    "market_cap_change_24h": 24163411019,
    "market_cap_change_percentage_24h": 7.94253,
    "circulating_supply": 19819343,
    "total_supply": 19819343,
    "max_supply": 21000000,
    "ath": 108786
    }
    ]
    """.data(using: .utf8)!
}
