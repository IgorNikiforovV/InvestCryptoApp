//
//  CoinImageViewModel.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 06.02.2025.
//

import SwiftUI

final class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false

    private let coin: CoinModel
    private let dataService: CoinImageService

    init(coin: CoinModel) {
        self.coin = coin
        dataService = CoinImageService(urlString: coin.image)
        getImage()
    }

    private func getImage() {

    }
}
