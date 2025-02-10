//
//  UIApplication.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 10.02.2025.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
