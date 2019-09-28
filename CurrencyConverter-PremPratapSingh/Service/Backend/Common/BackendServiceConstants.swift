//
//  BackendServiceConstants.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

enum BackendServiceConstants {
    enum HeaderName {
        static let authorization = "Authorization"
        static let contentType = "Content-Type"
        static let acceptType = "accept"
        static let csrfToken = "X-CSRFToken"
    }
    
    enum HeaderValue {
        static let applicationJSON = "application/json"
    }
    
    enum EndPoint: String {
        case currencySymbols = "symbols"
        case coversionRates = "latest"
        
        var value: String {
            return self.rawValue
        }
    }
}
