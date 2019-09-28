//
//  CurrencySymbolView.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import SwiftUI

struct CurrencySymbolView: View {
    var currency: Currency
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(currency.symbol.lowercased())
                .padding(10)
            Text(currency.symbol)
                .foregroundColor(.gray)
                .fontWeight(.bold)
            Spacer()
            Text(String(format: "%.2f", currency.conversionRate))
                .foregroundColor(.blue)
                .padding(10)
        }
    }
}

struct CurrencySymbolView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySymbolView(currency: Currency.example)
    }
}
