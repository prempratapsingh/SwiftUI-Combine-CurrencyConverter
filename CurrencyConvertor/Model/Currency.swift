//
//  Currency.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import Combine

class Currency: Codable, Identifiable {
    var id: String {
      return symbol
    }
    
    var symbol: String = ""
    var title: String = ""
    var conversionRate: Double = 0
    
    class var example: Currency {
        let currency = Currency()
        currency.symbol = "USD"
        currency.title = "United states dollers."
        currency.conversionRate = 0
        return currency
    }
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case title = "title"
        case conversionRate = "conversionRate"
    }
}
