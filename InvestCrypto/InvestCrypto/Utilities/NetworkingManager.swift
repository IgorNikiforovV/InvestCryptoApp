//
//  NetworkingManager.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 05.02.2025.
//

import Foundation
import Combine

// MARK: - Nested types

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL?)
        case unknown

        var errorDescription: String? {
            switch self {
            case let .badURLResponse(url): "[🔥] Bad response from URL: \(url?.absoluteString ?? "noURL")"
            case .unknown: "[⚠️] Unknown error occured"
            }
        }
    }
}

final class NetworkingManager {
    static func send(with urlRequest: URLRequest) -> AnyPublisher<Data, Error>
    {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { try handleURLResponse(output: $0, url: urlRequest.url) }
            .retry(3)
            .eraseToAnyPublisher()
    }

    static func handleURLResponse(
        output:  URLSession.DataTaskPublisher.Output,
        url: URL?
    ) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("finished")
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
