//
//  LaunchView.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 01.04.2025.
//

import SwiftUI

struct LaunchView: View {

    @State private var loadingText: [String] = "Loading your podtfolio...".map { String($0) }
    @State private var showLoadingtext = false
    let timer = Timer.publish(
        every: 0.1,
        on: .main,
        in: RunLoop.Mode.common
    ).autoconnect()
    @State private var counter: Int = 0

    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if showLoadingtext {
                    //                    Text(loadingText)
                    //                        .font(.headline)
                    //                        .fontWeight(.heavy)
                    //                        .foregroundStyle(Color.launch.accent)
                    //                        .transition(AnyTransition.scale.animation(.easeIn))
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.launch.accent)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeInOut))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingtext.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                counter += 1
            }
        }
    }
}

#Preview {
    LaunchView()
}
