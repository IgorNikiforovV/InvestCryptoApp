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
    @StateObject private var vm: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()

                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: nil,
                    content: {
                        ForEach(vm.overviewStatistics) { stat in
                            StatisticView(stat: stat)
                        }
                })

                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()

                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: nil,
                    content: {
                        ForEach(vm.additionalStatistics) { stat in
                            StatisticView(stat: stat)
                        }
                })
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
