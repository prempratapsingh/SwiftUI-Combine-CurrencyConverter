//
//  CurrencyListCoordinator.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

protocol CurrencyListCoordinatorDelegate: BaseCoordinator {
    func didStart(with currencyListViewController: CurrencyListViewController)
}

class CurrencyListCoordinator: BaseCoordinator {
    private var currencyListViewController: CurrencyListViewController!
    private var currencyConverterCoordinator: CurrencyConverterCoordinator!
    
    override func present(with dependencies: BaseModuleDependencies?) {
        super.present(with: dependencies)
        currencyListViewController = CurrencyListViewController()
        currencyListViewController.coordinatorDelegate = self
        let viewModel = CurrencyListViewModel(delegate: currencyListViewController, dependencies: dependencies)
        currencyListViewController.viewModel = viewModel
        guard let delegate = delegate as? CurrencyListCoordinatorDelegate else { return }
        delegate.didStart(with: currencyListViewController)
    }
    
    override func didDismiss(coordinator: BaseCoordinator) {
        super.didDismiss(coordinator: coordinator)
        if let _ = coordinator as? CurrencyConverterCoordinator {
            currencyConverterCoordinator = nil
        }
    }
}

extension CurrencyListCoordinator: CurrencyListViewControllerCoordinatorDelegate {
    func presentCurrencyConversionViewController(for baseCurrency: Currency, selectedCurrency: Currency) {
        let currencyConverterDependencies = CurrencyConverterDependencies()
        currencyConverterDependencies.baseCurrency = baseCurrency
        currencyConverterDependencies.selectedCurrency = selectedCurrency
        currencyConverterCoordinator = CurrencyConverterCoordinator(with: currencyListViewController)
        currencyConverterCoordinator.delegate = self
        currencyConverterCoordinator.present(with: currencyConverterDependencies)
    }
}
