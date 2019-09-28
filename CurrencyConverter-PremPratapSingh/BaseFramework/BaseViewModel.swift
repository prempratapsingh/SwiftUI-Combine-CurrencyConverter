//
//  BaseViewModel.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

protocol ViewDelegate: BaseViewController {}

class BaseViewModel {
    weak var viewDelegate: ViewDelegate!
    var dependencies: BaseModuleDependencies?
    
    init(delegate: ViewDelegate, dependencies: BaseModuleDependencies?) {
        self.viewDelegate = delegate
        self.dependencies = dependencies
    }
}
