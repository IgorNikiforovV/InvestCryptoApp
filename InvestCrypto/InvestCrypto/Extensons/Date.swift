//
//  Date.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 21.03.2025.
//

import Foundation

extension Date {
    // "2024-03-14T07:10:36.635Z"
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }

    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    var asShortDateString: String {
        shortFormatter.string(from: self)
    }
}
