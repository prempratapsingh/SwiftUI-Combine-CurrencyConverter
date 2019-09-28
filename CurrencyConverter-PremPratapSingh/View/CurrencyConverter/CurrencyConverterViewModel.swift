//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

class CurrencyConverterDependencies: BaseModuleDependencies {
    var baseCurrency: Currency?
    var selectedCurrency: Currency?
}

class CurrencyConverterViewModel: BaseViewModel {
    var baseCurrency: Currency? {
        guard let dependencies = dependencies as? CurrencyConverterDependencies else { return nil }
        return dependencies.baseCurrency
    }
    
    var conversionCurrency: Currency? {
        guard let dependencies = dependencies as? CurrencyConverterDependencies else { return nil }
        return dependencies.selectedCurrency
    }
}
