//
//  HomeViewModel.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 03.02.2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
