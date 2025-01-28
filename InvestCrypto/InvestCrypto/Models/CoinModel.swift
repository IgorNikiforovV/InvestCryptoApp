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

 */

class CoinModel {

}
