//
//  CoinImageService.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 06.02.2025.
//

import SwiftUI
import Combine

class ImageService {

    @Published var image: UIImage?
    private var imageSubscription: AnyCancellable?
    private let fileManager = LocalFileManager.instance
    var action: ((UIImage?) -> Void)?

    init(){}

    func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageSubscription = NetworkingManager.send(with: URLRequest(url: url))
            .tryMap({ data -> UIImage? in
                UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
                self?.action?(returnedImage)
            })
    }
}
