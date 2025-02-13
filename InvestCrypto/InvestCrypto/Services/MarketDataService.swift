//
//  MarketDataService.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 13.02.2025.
//

import Foundation
import Combine

// MARK: Nested types

extension MarketDataService {
    private enum Const {
        static let currency = (name: "vs_currency", value: "usd")
        static let method = "GET"
        static let accept = (name: "accept", value: "application/json")
        static let key = (name: "x-cg-demo-api-key", value: "CG-RspF9kDAPWeqfA2hEMgQcDYF")
    }
}

final class MarketDataService {
    private let url = URL(string: "https://api.coingecko.com/api/v3/global")!

    @Published var marketData: MarketDataModel?

    var marketDataSubscription: AnyCancellable?

    init() {
        getMarketData()
    }

    private func getMarketData() {
        marketDataSubscription = NetworkingManager.send(with: urlRequest)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedMarGlobalData in
                self?.marketData = returnedMarGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}

extension MarketDataService {
    private var urlRequest: URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: Const.currency.name, value: Const.currency.value),
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
