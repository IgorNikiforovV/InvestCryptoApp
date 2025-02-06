//
//  CoinImageService.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 06.02.2025.
//

import SwiftUI
import Combine

final class CoinImageService {

    @Published var image: UIImage?

    private var imageSubscription: AnyCancellable?

    init(urlString: String) {
        getCoinImage(urlString: urlString)
    }

    private func getCoinImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        imageSubscription = NetworkingManager.send(with: URLRequest(url: url))
            .tryMap({ data -> UIImage? in
                UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
