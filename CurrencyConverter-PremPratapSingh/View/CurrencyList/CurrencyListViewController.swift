//
//  CurrencyListViewController.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

protocol CurrencyListViewControllerCoordinatorDelegate: class {
    func presentCurrencyConversionViewController(for baseCurrency: Currency, selectedCurrency: Currency)
}

class CurrencyListViewController: BaseViewController {
    private var currencySelectorButton: UIButton!
    private var currencySelector: UIPickerView!
    private var currencyListTableView: UITableView!
    private var baseCurrency: Currency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCurrencySelectorButton()
        configureCurrencyListTableView()
        configureCurrencySelector()
        getCurrencyList()
    }
    
    private func getCurrencyList() {
        guard let viewModel = viewModel as? CurrencyListViewModel else { return }
        presentIndicatorView()
        setControlsVisibility(to: false)
        setConstrolsEnabledState(to: false)
        viewModel.getCurrencyList()
    }
    
    private func getConversionRates(for currency: String) {
        guard let viewModel = viewModel as? CurrencyListViewModel else { return }
        presentIndicatorView()
        setConstrolsEnabledState(to: false)
        viewModel.getCurrencyConversions(for: currency)
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(red: 105/255, green: 190/255, blue: 255/255, alpha: 1.0)
    }
    
    private func setCurrencySelectorButtonIcon(for currency: Currency) {
        if let iconImage = UIImage(named: currency.symbol.lowercased()) {
            currencySelectorButton.setImage(iconImage, for: .normal)
        } else {
            currencySelectorButton.setImage(UIImage(named: "defaultFlag"), for: .normal)
        }
        currencySelectorButton.setTitle(currency.symbol, for: .normal)
    }
    
    private func configureCurrencySelectorButton() {
        currencySelectorButton = UIButton(frame: .zero)
        currencySelectorButton.backgroundColor = .white
        currencySelectorButton.layer.cornerRadius = 10
        currencySelectorButton.setTitleColor(.black, for: .normal)
        currencySelectorButton.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 20.0, bottom: 5.0, right: 5.0)
        currencySelectorButton.addTarget(self, action: #selector(didTapOnCurrencySelectorButton), for: .touchUpInside)
        view.addSubview(currencySelectorButton)
        currencySelectorButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencySelectorButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            currencySelectorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            currencySelectorButton.widthAnchor.constraint(equalToConstant: 125),
            currencySelectorButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureCurrencyListTableView() {
        currencyListTableView = UITableView(frame: .zero)
        currencyListTableView.delegate = self
        currencyListTableView.dataSource = self
        currencyListTableView.register(CurrencyConversionRateTableViewCell.self, forCellReuseIdentifier: CurrencyConversionRateTableViewCell.identifier)
        view.addSubview(currencyListTableView)
        currencyListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyListTableView.topAnchor.constraint(equalTo: currencySelectorButton.bottomAnchor, constant: 24),
            currencyListTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            currencyListTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            currencyListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func configureCurrencySelector() {
        currencySelector = UIPickerView(frame: .zero)
        currencySelector.dataSource = self
        currencySelector.delegate = self
        currencySelector.alpha = 0
        currencySelector.backgroundColor = .white
        currencySelector.isUserInteractionEnabled = false
        view.addSubview(currencySelector)
        currencySelector.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencySelector.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            currencySelector.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            currencySelector.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            currencySelector.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func scrollTableViewToTop() {
        currencyListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
    
    private func setConstrolsEnabledState(to isEnabled: Bool) {
        currencySelectorButton.isUserInteractionEnabled = isEnabled
        currencyListTableView.isUserInteractionEnabled = isEnabled
        currencySelector.isUserInteractionEnabled = isEnabled
    }
    
    private func setControlsVisibility(to isVisible: Bool) {
        currencySelectorButton.isHidden = !isVisible
        currencyListTableView.isHidden = !isVisible
        currencySelector.isHidden = !isVisible
    }
    
    @objc func didTapOnCurrencySelectorButton() {
        currencySelectorButton.isUserInteractionEnabled = false
        currencyListTableView.isUserInteractionEnabled = false
        currencySelector.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.2, animations: { self.currencySelector.alpha = 1 })
    }
}

extension CurrencyListViewController: CurrencyListViewModeViewDelegate {
    func didLoadCurrencyList() {
        dismissIndicatorView()
        setControlsVisibility(to: true)
        setConstrolsEnabledState(to: true)
        currencySelector.reloadComponent(0)
        guard let viewModel = viewModel as? CurrencyListViewModel, viewModel.currencies.count > 0 else { return }
        let currency = viewModel.currencies[0]
        baseCurrency = currency
        setCurrencySelectorButtonIcon(for: currency)
        getConversionRates(for: currency.symbol)
    }
    
    func didCurrencyListLoadFail(with error: ATCError) {
        dismissIndicatorView()
        print(error.description)
    }
    
    func didLoadConversionRates() {
        dismissIndicatorView()
        setConstrolsEnabledState(to: true)
        currencyListTableView.reloadData()
        scrollTableViewToTop()
    }
    
    func didConversionRatesLoadFail(with error: ATCError) {
        dismissIndicatorView()
        setConstrolsEnabledState(to: true)
        print(error.description)
    }
}

extension CurrencyListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel as? CurrencyListViewModel else { return 0 }
        return viewModel.conversionRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel as? CurrencyListViewModel else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyConversionRateTableViewCell.identifier, for: indexPath) as? CurrencyConversionRateTableViewCell {
            let currency = viewModel.conversionRates[indexPath.row]
            cell.delegate = self
            cell.configure(with: currency)
            return cell
            
        }
        return UITableViewCell()
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Show currency converter view")
    }
}

extension CurrencyListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let viewModel = viewModel as? CurrencyListViewModel else { return 0 }
        return viewModel.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let viewModel = viewModel as? CurrencyListViewModel else { return UIView() }
        let view = CurrencyCodeView()
        view.configure(with: viewModel.currencies[row])
        return view
    }
}

extension CurrencyListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let viewModel = viewModel as? CurrencyListViewModel else { return }
        let currency = viewModel.currencies[row]
        baseCurrency = currency
        setCurrencySelectorButtonIcon(for: currency)
        getConversionRates(for: currency.symbol)
        currencySelectorButton.isUserInteractionEnabled = true
        currencyListTableView.isUserInteractionEnabled = true
        currencySelector.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2, animations: { pickerView.alpha = 0 })
    }
}

extension CurrencyListViewController: CurrencyConversionRateTableViewCellDelegate {
    func didSelectCurrencyConverion(_ conversion: Currency) {
        guard let delegate = coordinatorDelegate as? CurrencyListViewControllerCoordinatorDelegate else { return }
        delegate.presentCurrencyConversionViewController(for: baseCurrency, selectedCurrency: conversion)
    }
}
