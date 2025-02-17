//
//  PortfolioView.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 17.02.2025.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)

                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHStack(spacing: 10) {
                            ForEach(vm.allCoins) { coin in
                                Text(coin.symbol.uppercased())
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            })
        }
    }
}

#Preview {
    PortfolioView()
}
