//
//  DetailView.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 28.02.2025.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {

    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        print("Initializing Detail View for \(coin.name)")
    }

    var body: some View {
        Text(coin.name)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
