//
//  Currency.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

class Currency: Codable {
    var symbol: String = ""
    var title: String = ""
    var conversionRate: Double = 0
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case title = "title"
        case conversionRate = "conversionRate"
    }
}
