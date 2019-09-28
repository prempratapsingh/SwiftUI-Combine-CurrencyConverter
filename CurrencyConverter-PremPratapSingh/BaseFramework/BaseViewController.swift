//
//  BaseViewController.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController, ViewDelegate {
    weak var coordinatorDelegate: BaseCoordinator!
    var viewModel: BaseViewModel!
    var slideInDirection: SlideDirection = .fromRight
    var slideOutDirection: SlideDirection = .toRight
    
    private lazy var overlayView: UIView = {
        let ovrlyView = UIView(frame: view.bounds)
        ovrlyView.backgroundColor = UIColor.clear
        ovrlyView.alpha = 0
        return ovrlyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGesture()
        configureSwipeGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func presentIndicatorView() {
        view.addSubview(overlayView)
        view.bringSubviewToFront(overlayView)
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func dismissIndicatorView() {
        overlayView.removeFromSuperview()
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func didSwipeLeft() {}
    func didSwipeRight() {}
}

extension BaseViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let slideTransition = SlideTransition()
        slideTransition.slideDirection = slideInDirection
        return slideTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let slideTransition = SlideTransition()
        slideTransition.slideDirection = slideOutDirection
        return slideTransition
    }
}

extension BaseViewController {
    private func configureTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureSwipeGesture() {
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeScreen))
        swipeLeftGestureRecognizer.direction = .left
        view.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeScreen))
        swipeRightGestureRecognizer.direction = .right
        view.addGestureRecognizer(swipeRightGestureRecognizer)
    }
    
    @objc private func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    @objc private func didSwipeScreen(recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == .left {
            didSwipeLeft()
        } else if recognizer.direction == .right {
            didSwipeRight()
        }
    }
}
