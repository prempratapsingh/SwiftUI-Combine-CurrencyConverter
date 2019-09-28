//
//  BackendServiceURL.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

class BackendServiceURL {
    static let environment = ""
    static let baseUrl = "http://data.fixer.io/api/"
    static let baseURL_ExchangeRatesAPI = "https://api.exchangeratesapi.io/"
    
    static func getQualifiedUrl(for endPoint: String) -> String {
        let qualifiedUrl = String(format: "\(baseUrl)%@", endPoint)
        return qualifiedUrl
    }
    
    static func getQualifiedUrlForExchangeRatesAPI(for endPoint: String) -> String {
        let qualifiedUrl = String(format: "\(baseURL_ExchangeRatesAPI)%@", endPoint)
        return qualifiedUrl
    }
}
