//
//  DetailView.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 28.02.2025.
//

import SwiftUI

struct DetailView: View {

    let coin: CoinModel

    var body: some View {
        Text(coin.name)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
