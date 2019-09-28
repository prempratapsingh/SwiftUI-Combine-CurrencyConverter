//
//  CurrencyListViewModel.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import Combine

class CurrencyListViewModel: ObservableObject {
    @Published var currencies = [Currency]()
    @Published var conversionRates = [Currency]()
    @Published var selectedCurrencyIndex = 0
    @Published var isLoadInProgress = false
    
    private var currencyListBackendService: CurrencyListBackendService!
    private var currencyCoversionRatesBackendService: CurrencyCoversionRatesBackendService!
    private var scheduler: DispatchQueue!
    
    init() {
        scheduler = DispatchQueue(label: "CurrencyListViewModel")
        _ = $selectedCurrencyIndex
        .dropFirst(1)
        .debounce(for: .seconds(0.5), scheduler: scheduler)
        .sink(receiveValue: getCurrencyConversions(for:))
    }
    
    func getCurrencyList() {
        if currencyListBackendService == nil {
            currencyListBackendService = CurrencyListBackendService(endPoint: BackendServiceConstants.EndPoint.currencySymbols.value)
        }
        isLoadInProgress = true
        currencyListBackendService.getCurrencyList(
            responseHandler: { [weak self] currencies in
                guard let strongSelf = self else { return }
                strongSelf.isLoadInProgress = false
                strongSelf.currencies = currencies.sorted { $0.symbol.lowercased() < $1.symbol.lowercased() }
                if strongSelf.currencies.count > 0 {
                    strongSelf.getCurrencyConversions(for: 0)
                }
        },
            errorHandler: { error in
                print(error)
        })
    }
    
    func getCurrencyConversions(for currencyIndex: Int) {
        guard !currencies.isEmpty else { return }
        if currencyCoversionRatesBackendService == nil {
            currencyCoversionRatesBackendService = CurrencyCoversionRatesBackendService(endPoint: BackendServiceConstants.EndPoint.coversionRates.value)
        }
        let currency = currencies[currencyIndex].symbol
        currencyCoversionRatesBackendService.getCurrencyConversions(
            for: currency,
            responseHandler: { [weak self] conversionRates in
                guard let strongSelf = self else { return }
                strongSelf.conversionRates = conversionRates.sorted { $0.symbol.lowercased() < $1.symbol.lowercased() }
            },
            errorHandler: { error in
                print(error)
        })
    }
}
