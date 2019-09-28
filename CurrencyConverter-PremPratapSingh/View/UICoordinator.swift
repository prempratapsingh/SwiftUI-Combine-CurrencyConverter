//
//  UICoordinator.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

class UICoordinator: BaseCoordinator {
    var window: UIWindow!
    private var currencyListCoordinator: CurrencyListCoordinator!
    private var currencyListViewController: CurrencyListViewController!
    
    override func present(with dependencies: BaseModuleDependencies?) {
        super.present(with: dependencies)
        presentCurrencyListViewController()
    }
    
    private func presentCurrencyListViewController() {
        currencyListCoordinator = CurrencyListCoordinator(with: nil)
        currencyListCoordinator.delegate = self
        let depenencies = BaseModuleDependencies()
        currencyListCoordinator.present(with: depenencies)
    }
}

extension UICoordinator: CurrencyListCoordinatorDelegate {
    func didStart(with viewController: CurrencyListViewController) {
        currencyListViewController = viewController
        window.rootViewController = currencyListViewController
    }
}
