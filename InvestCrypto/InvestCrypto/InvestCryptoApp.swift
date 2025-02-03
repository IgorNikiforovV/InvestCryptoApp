//
//  InvestCryptoApp.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 23.01.2025.
//

import SwiftUI

@main
struct InvestCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
