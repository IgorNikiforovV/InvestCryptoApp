//
//  ChartView.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 19.03.2025.
//

import SwiftUI

struct ChartView: View {

    let data: [Double]

    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
    }

    // 300
    // 100
    // 3
    // 1 * 3 = 3
    // 2 * 3 = 6
    // 3 * 3 = 9
    // 100 * 3 = 300

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    if index == 0 {
                        path.move(to: CGPoint(x: 0, y: 0))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: 0))
                }
            }
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        }
    }
}

struct ChartView_Preview: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
            .frame(width: 200)
    }
}
