//
//  DetailViewModel.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 03.03.2025.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("RECIEVED COIN DETAIL DATA")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}
