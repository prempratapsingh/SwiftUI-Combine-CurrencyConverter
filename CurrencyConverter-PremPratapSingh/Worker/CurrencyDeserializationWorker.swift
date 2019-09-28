//
//  CurrencyDeserializationWorker.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 20/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import SwiftyJSON

class CurrencyDeserializationWorker {
    var currencyJson: [[String: Any]]?
    
    init(with json: [[String: Any]]) {
        self.currencyJson = json
    }
    
    init() {}
    
    func deserilazeCurrencies() -> [Currency]? {
        guard let json = currencyJson else { return nil }
        do {
            var currencies = [Currency]()
            let decoder = JSONDecoder()
            for crncyJson in json {
                let jsonData = try JSONSerialization.data(withJSONObject: crncyJson, options: [])
                let currency = try decoder.decode(Currency.self, from: jsonData)
                currencies.append(currency)
            }
            return currencies
        } catch {
            print("Error parsing user object. \(error)")
        }
        return nil
    }
}
