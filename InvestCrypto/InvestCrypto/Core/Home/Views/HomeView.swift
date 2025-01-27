//
//  HomeView.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 25.01.2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false

    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()

            // content layer
            VStack {
                homeHeader

                Spacer(minLength: 0)
            }
        }
    }
}

extension HomeView {
    var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Life Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}


#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
}
