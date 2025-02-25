//
//  HapticManager.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 25.02.2025.
//

import SwiftUI

final class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
