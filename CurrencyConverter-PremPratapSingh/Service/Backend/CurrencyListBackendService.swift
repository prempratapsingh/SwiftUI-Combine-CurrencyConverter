//
//  CurrencyListBackendService.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 20/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrencyListBackendService: BackendService {
    let supportedCurrencies = ["CAD", "HKD", "ISK", "PHP", "DKK", "HUF", "CZK", "GBP", "RON", "SEK", "IDR", "INR", "BRL", "RUB", "HRK", "JPY", "THB", "CHF", "EUR", "MYR", "BGN", "TRY", "CNY", "NOK", "NZD", "ZAR", "USD", "MXN", "SGD", "AUD", "ILS", "KRW", "PLN"]
    
    func getCurrencyList(responseHandler: @escaping CurrencyListResponseHandler,
                         errorHandler: @escaping ErrorHandler) {
        let parameters: [String: Any] = [
            "access_key": "f46a7248841eb9d9217cbe5c4e57a1f0",
            "format": 1
        ]
        httpMethod = .get
        encoding = URLEncoding.default
        super.request(
            parameters: parameters,
            responseHandler: { [weak self] response in
                guard let strongSelf = self,
                    let response = response.result.value as? [String: Any],
                    let currenciesJSON = response["symbols"] as? [String: Any] else {
                        errorHandler(ATCError.genericBackendError)
                        return
                }
                
                var currencies = [Currency]()
                for (key, value) in currenciesJSON {
                    if let index = strongSelf.supportedCurrencies.lastIndex(of: key.uppercased()), index >= 0 {
                        let currency = Currency()
                        currency.symbol = key
                        currency.title = value as! String
                        currencies.append(currency)
                    }
                }
                if currencies.count > 0 {
                    responseHandler(currencies)
                } else {
                    let error = ATCError(type: .noResults, code: 0, description: "Oops! Something went wrong, couldn't load the currencies.")
                    errorHandler(error)
                }
            },
            errorHandler: { error in
                errorHandler(error)
        })
    }
}
