//
//  SettingsView.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 26.03.2025.
//

import SwiftUI

struct SettingsView: View {
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfullthinking")!
    let coffeeURL = URL(string: "https://bymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://coingecko.com")!

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("header")) {
                    Text("Hi")
                    Text("Hi")
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
