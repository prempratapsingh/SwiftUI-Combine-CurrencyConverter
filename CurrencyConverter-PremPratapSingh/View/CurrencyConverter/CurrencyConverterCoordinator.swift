//
//  CurrencyConverterCoordinator.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import AVKit

class CurrencyConverterCoordinator: BaseCoordinator {
    private var currencyConverterViewController: CurrencyConverterViewController!
    
    override func present(with dependencies: BaseModuleDependencies?) {
        guard let parentViewController = parentViewController else { return }
        currencyConverterViewController = CurrencyConverterViewController()
        currencyConverterViewController.coordinatorDelegate = self
        let viewModel = CurrencyConverterViewModel(delegate: currencyConverterViewController, dependencies: dependencies)
        currencyConverterViewController.viewModel = viewModel
        currencyConverterViewController.modalPresentationStyle = .custom
        currencyConverterViewController.transitioningDelegate = parentViewController as UIViewControllerTransitioningDelegate
        parentViewController.present(currencyConverterViewController, animated: true)
    }
    
    override func dismiss() {
        guard let coordinatorDelegate = delegate else { return }
        coordinatorDelegate.didDismiss(coordinator: self)
    }
}
