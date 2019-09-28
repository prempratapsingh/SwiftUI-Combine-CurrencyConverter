//
//  BaseCoordinator.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func present(with dependencies: BaseModuleDependencies?)
}

class BaseCoordinator: NSObject, Coordinator {
    weak var delegate: BaseCoordinator?
    weak var parentViewController: BaseViewController?
    
    init(with parentViewController: BaseViewController?) {
        self.parentViewController = parentViewController
    }
    
    func present(with dependencies: BaseModuleDependencies?) {}
    func dismiss() {}
    func didDismiss(coordinator: BaseCoordinator) {}
}
