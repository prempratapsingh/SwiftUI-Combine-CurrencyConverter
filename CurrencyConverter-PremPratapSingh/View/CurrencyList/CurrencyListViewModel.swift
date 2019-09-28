//
//  CurrencyListViewModel.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

protocol CurrencyListViewModeViewDelegate: BaseViewController {
    func didLoadCurrencyList()
    func didCurrencyListLoadFail(with error: ATCError)
    func didLoadConversionRates()
    func didConversionRatesLoadFail(with error: ATCError)
}

class CurrencyListViewModel: BaseViewModel {
    var currencies = [Currency]()
    var conversionRates = [Currency]()
    
    private var currencyListBackendService: CurrencyListBackendService!
    private var currencyCoversionRatesBackendService: CurrencyCoversionRatesBackendService!
    
    func getCurrencyList() {
        if currencyListBackendService == nil {
            currencyListBackendService = CurrencyListBackendService(endPoint: BackendServiceConstants.EndPoint.currencySymbols.value)
        }
        currencyListBackendService.getCurrencyList(
            responseHandler: { [weak self] currencies in
                guard let strongSelf = self,
                    let delegate = strongSelf.viewDelegate as? CurrencyListViewModeViewDelegate else { return }
                strongSelf.currencies = currencies.sorted { $0.symbol.lowercased() < $1.symbol.lowercased() }
                delegate.didLoadCurrencyList()
                
        },
            errorHandler: {[weak self] error in
                guard let strongSelf = self,
                    let delegate = strongSelf.viewDelegate as? CurrencyListViewModeViewDelegate  else { return }
                delegate.didCurrencyListLoadFail(with: error)
        })
    }
    
    func getCurrencyConversions(for currency: String) {
        if currencyCoversionRatesBackendService == nil {
            currencyCoversionRatesBackendService = CurrencyCoversionRatesBackendService(endPoint: BackendServiceConstants.EndPoint.coversionRates.value)
        }
        currencyCoversionRatesBackendService.getCurrencyConversions(
            for: currency,
            responseHandler: { [weak self] conversionRates in
                guard let strongSelf = self,
                    let delegate = strongSelf.viewDelegate as? CurrencyListViewModeViewDelegate else { return }
                strongSelf.conversionRates = conversionRates.sorted { $0.symbol.lowercased() < $1.symbol.lowercased() }
                delegate.didLoadConversionRates()
            },
            errorHandler: { [weak self] error in
                guard let strongSelf = self,
                    let delegate = strongSelf.viewDelegate as? CurrencyListViewModeViewDelegate  else { return }
                delegate.didConversionRatesLoadFail(with: error)
        })
    }
}
