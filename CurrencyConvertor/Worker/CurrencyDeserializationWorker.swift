//
//  CurrencyDeserializationWorker.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import SwiftyJSON

class CurrencyDeserializationWorker {
    let supportedCurrencies = ["CAD", "HKD", "ISK", "PHP", "DKK", "HUF", "CZK", "GBP", "RON", "SEK", "IDR", "INR", "BRL", "RUB", "HRK", "JPY", "THB", "CHF", "EUR", "MYR", "BGN", "TRY", "CNY", "NOK", "NZD", "ZAR", "USD", "MXN", "SGD", "AUD", "ILS", "KRW", "PLN"]
    var currencyJson: [String: Any]?
    
    init(with json: [String: Any]) {
        self.currencyJson = json
    }
    
    init() {}
    
    func deserilazeCurrencies() -> [Currency]? {
        guard let json = currencyJson else { return nil }
        var currencies = [Currency]()
        for (key, value) in json {
            if let index = supportedCurrencies.lastIndex(of: key.uppercased()), index >= 0 {
                let currency = Currency()
                currency.symbol = key
                if let title = value as? String {
                    currency.title = title
                } else if let rate = value as? Double {
                    currency.conversionRate = rate
                }
                currencies.append(currency)
            }
        }
        return currencies
    }
}

