//
//  XMarkButton.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 17.02.2025.
//

import SwiftUI

struct XMarkButton: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}
