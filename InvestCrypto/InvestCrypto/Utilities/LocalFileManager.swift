//
//  LocalFileManager.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 08.02.2025.
//

import Foundation
import UIKit

final class LocalFileManager {
    static let instance = LocalFileManager()

    private init() {}

    func saveImage(
        image: UIImage,
        imageName: String,
        folderName: String
    ) {
        guard
            let data = image.pngData(),
            let url = getURLForImage(
                imageName: imageName,
                folderName: folderName
            )
        else { return }
        
        do {
            try data.write(to: url)
        } catch {
            print("Error saving imge. \(error)")
        }
    }

    private func createFolderIfNeeded(folderName: String) {
        guard 
            let url = getURLForFolder(folderName: folderName)
        else { return }

        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(
                    at: url,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                print("Error creating directory. \(error)")
            }
        }

    }

    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }

        return url.appendingPathComponent(folderName)
    }

    private func getURLForImage(
        imageName: String,
        folderName: String
    ) -> URL? {
        guard
            let folderURL = getURLForFolder(folderName: folderName)
        else { return nil }

        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
