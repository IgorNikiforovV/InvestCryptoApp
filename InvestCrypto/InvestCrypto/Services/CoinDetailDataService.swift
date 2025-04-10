//
//  CoinDetailDataService.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 03.03.2025.
//

import Foundation
import Combine

final class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel?
    private var coinDetailSubscription: AnyCancellable?

    private let url: URL
    private let coin: CoinModel


    init(coin: CoinModel) {
        self.coin = coin
        url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)")!
        getCoinDetails()
    }

    func getCoinDetails() {
        coinDetailSubscription = NetworkingManager.send(with: urlRequest)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }

    private var urlRequest: URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            CoinURLConst.CoinDetail.tickers,
            CoinURLConst.CoinDetail.sparkline,
            CoinURLConst.CoinDetail.marketData,
            CoinURLConst.CoinDetail.developerData,
            CoinURLConst.CoinDetail.communityData,
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = CoinURLConst.All.method
        request.timeoutInterval = CoinURLConst.All.timeoutInterval
        request.allHTTPHeaderFields = CoinURLConst.All.allHTTPHeaderFields

        return request
    }
}
