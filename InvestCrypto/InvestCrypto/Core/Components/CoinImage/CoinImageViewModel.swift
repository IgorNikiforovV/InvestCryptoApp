//
//  CoinImageViewModel.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 06.02.2025.
//

import SwiftUI
import Combine

final class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false

    private let coin: CoinModel
    private let dataService: ImageService
    private var imageSubscription: AnyCancellable?

    init(coin: CoinModel) {
        self.coin = coin
        dataService = ImageService(urlString: coin.image)
        addSubscribers()
        isLoading = true
    }

    private func addSubscribers() {
        imageSubscription = dataService.$image
            .sink(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            }, receiveValue: { [weak self] image in
                self?.image = image
                self?.imageSubscription?.cancel() 
            })
    }
}
