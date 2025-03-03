//
//  CoinURLConstants.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 03.03.2025.
//

import Foundation

enum CoinURLConst {
    enum All {
        static let method = "GET"
        static let accept = (name: "accept", value: "application/json")
        static let key = (name: "x-cg-demo-api-key", value: "CG-RspF9kDAPWeqfA2hEMgQcDYF")
    }
    enum Coin {
        static let currency = URLQueryItem(name: "vs_currency", value: "usd")
        static let page = URLQueryItem(name: "page", value: "1")
        static let perPage = URLQueryItem(name: "per_page", value: "50")
        static let sparkline = URLQueryItem(name: "sparkline", value: "true")
        static let percentage24 = URLQueryItem(name: "price_change_percentage", value: "24h")
    }

    enum CoinDetail {
        static let localization = URLQueryItem(name: "localization", value: "false")
        static let tickers = URLQueryItem(name: "tickers", value: "false")
        static let marketData = URLQueryItem(name: "market_data", value: "false")
        static let communityData = URLQueryItem(name: "community_data", value: "false")
        static let developerData = URLQueryItem(name: "developer_data", value: "false")
        static let sparkline = URLQueryItem(name: "sparkline", value: "false")
    }
}
