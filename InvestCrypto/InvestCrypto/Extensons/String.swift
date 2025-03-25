//
//  String.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 25.03.2025.
//

import Foundation

extension String {
    var removeingHTMLOccurances: String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
