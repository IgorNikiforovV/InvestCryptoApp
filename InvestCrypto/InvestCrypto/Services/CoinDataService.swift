//
//  CoinDataService.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 04.02.2025.
//

import Foundation
import Combine

final class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    private var coinSubscription: AnyCancellable?

    private let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!

    init() {
        getCoins()
    }

    func getCoins() {
        coinSubscription = NetworkingManager.send(with: urlRequest)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }

    private var urlRequest: URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            CoinURLConst.Coin.currency,
            CoinURLConst.Coin.page,
            CoinURLConst.Coin.perPage,
            CoinURLConst.Coin.sparkline,
            CoinURLConst.Coin.percentage24,
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = CoinURLConst.All.method
        request.timeoutInterval = CoinURLConst.All.timeoutInterval
        request.allHTTPHeaderFields = CoinURLConst.All.allHTTPHeaderFields

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
