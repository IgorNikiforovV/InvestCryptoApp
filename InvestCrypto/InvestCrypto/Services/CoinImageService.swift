//
//  CoinImageService.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 09.02.2025.
//

import Foundation
import UIKit

final class CoinImageService: ImageService {
    private let foldeName = "coin_images"
    private let fileManager = LocalFileManager.instance
    private let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        super.init()

        action = { [weak self] image in
            guard let self, let image else { return }
            fileManager.saveImage(
                image: image,
                imageName: coin.id,
                folderName: foldeName
            )
        }

        getCoinImage()
    }

    func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: foldeName) {
            image = savedImage
        } else {
            downloadImage(urlString: coin.image)
        }
    }
}
