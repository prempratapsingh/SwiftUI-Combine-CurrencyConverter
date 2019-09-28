//
//  ActivityIndicatorView.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView: View {
    @State var shouldSpin = false

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.5, to: 1)
                .stroke(Color.orange, lineWidth: 2)
                .frame(width: 50)
                .rotationEffect(.degrees(shouldSpin ? 0 : -360), anchor: .center)
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
        }
        .onAppear {
            self.shouldSpin = true
        }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
