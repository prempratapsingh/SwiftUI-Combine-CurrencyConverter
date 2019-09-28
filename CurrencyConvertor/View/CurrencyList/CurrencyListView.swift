//
//  CurrencyListView.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import SwiftUI

struct CurrencyListView: View {
    @ObservedObject var viewModel = CurrencyListViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.currencies.isEmpty {
                ActivityIndicatorView()
                .frame(width: 50, height: 50, alignment: .center)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    Form {
                        Section {
                            Picker(selection: $viewModel.selectedCurrencyIndex,
                                   label: Text("Currency")
                                    .fontWeight(.bold)) {
                                ForEach(0 ..< viewModel.currencies.count) {
                                    Text(self.viewModel.currencies[$0].symbol)
                                }
                            }
                        }
                    }.frame(height: 40)
                    Text("Currency conversion rates are listed below,")
                        .fontWeight(.bold)
                    List {
                        ForEach(viewModel.conversionRates) { currency in
                            CurrencySymbolView(currency: currency)
                        }
                    }
                }
                .padding(10)
                .navigationBarTitle("Currency Convertor")
            }
            
        }.onAppear(perform: {
            self.viewModel.getCurrencyList()
        })
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
