//
//  CoinImageService.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 06.02.2025.
//

import SwiftUI
import Combine

final class ImageService {

    @Published var image: UIImage?

    private var imageSubscription: AnyCancellable?

    init(urlString: String) {
        getImage(urlString: urlString)
    }

    private func getImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        print("Downloading image now")
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
