//
//  CoinModel.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 28.01.2025.
//

import Foundation

/// CoinGecko API info
/*

 import Foundation

 let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
 var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
 let queryItems: [URLQueryItem] = [
   URLQueryItem(name: "vs_currency", value: "usd"),
   URLQueryItem(name: "per_page", value: "100"),
   URLQueryItem(name: "page", value: "1"),
   URLQueryItem(name: "sparkline", value: "true"),
   URLQueryItem(name: "price_change_percentage", value: "24h"),
 ]
 components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

 var request = URLRequest(url: components.url!)
 request.httpMethod = "GET"
 request.timeoutInterval = 10
 request.allHTTPHeaderFields = [
   "accept": "application/json",
   "x-cg-demo-api-key": "CG-RspF9kDAPWeqfA2hEMgQcDYF"
 ]

 let (data, _) = try await URLSession.shared.data(for: request)
 print(String(decoding: data, as: UTF8.self))


 JSON Response:
 [
   {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 70187,
     "market_cap": 1381651251183,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1474623675796,
     "total_volume": 20154184933,
     "high_24h": 70215,
     "low_24h": 68060,
     "price_change_24h": 2126.88,
     "price_change_percentage_24h": 3.12502,
     "market_cap_change_24h": 44287678051,
     "market_cap_change_percentage_24h": 3.31157,
     "circulating_supply": 19675987,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 73738,
     "ath_change_percentage": -4.77063,
     "ath_date": "2024-03-14T07:10:36.635Z",
     "atl": 67.81,
     "atl_change_percentage": 103455.83335,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2024-04-07T16:49:31.736Z"
   }
 ]

 */

final class CoinModel {
    /// bitcoin
    let id: String
    /// btc
    let symbol: String
    /// Bitcoin
    let name: String
    /// "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"
    let image: String

}
