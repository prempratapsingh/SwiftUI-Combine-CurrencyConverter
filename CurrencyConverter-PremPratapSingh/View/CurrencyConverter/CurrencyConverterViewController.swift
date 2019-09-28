//
//  CurrencyConverterViewController.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: BaseViewController {
    private var backButton: UIButton!
    private var baseCurrencyTextField: UITextField!
    private var baseCurrencyLabel: UILabel!
    private var conversionCurrencyTextField: UITextField!
    private var conversionCurrencyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        configureBackButton()
        configureBaseCurrencyView()
        configureConversionCurrencyView()
    }
    
    private func configureBackButton() {
        backButton = UIButton(frame: .zero)
        let icon = UIImage(named: "backButton")
        backButton.setImage(icon, for: .normal)
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        backButton.addTarget(self, action: #selector(didTapOnBackButton), for:  .touchUpInside)
    }
    
    private func configureBaseCurrencyView() {
        baseCurrencyTextField = UITextField(frame: .zero)
        baseCurrencyTextField.font = UIFont(name: "Avenir-Book", size: 28)
        baseCurrencyTextField.delegate = self
        baseCurrencyTextField.keyboardType = .numberPad
        view.addSubview(baseCurrencyTextField)
        baseCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseCurrencyTextField.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
            baseCurrencyTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            baseCurrencyTextField.widthAnchor.constraint(equalToConstant: 200),
            baseCurrencyTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        baseCurrencyLabel = UILabel(frame: .zero)
        baseCurrencyLabel.textAlignment = .right
        view.addSubview(baseCurrencyLabel)
        baseCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseCurrencyLabel.centerYAnchor.constraint(equalTo: baseCurrencyTextField.centerYAnchor, constant: 0),
            baseCurrencyLabel.leftAnchor.constraint(equalTo: baseCurrencyTextField.rightAnchor, constant: 10),
            baseCurrencyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            baseCurrencyLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        guard let viewModel = viewModel as? CurrencyConverterViewModel,
            let baseCurrency = viewModel.baseCurrency else { return }
        baseCurrency.conversionRate = 1.0
        baseCurrencyTextField.text = String(format: "%.2f", baseCurrency.conversionRate)
        baseCurrencyLabel.text = baseCurrency.symbol
    }
    
    private func configureConversionCurrencyView() {
        conversionCurrencyTextField = UITextField(frame: .zero)
        conversionCurrencyTextField.font = UIFont(name: "Avenir-Book", size: 28)
        conversionCurrencyTextField.isEnabled = false
        conversionCurrencyTextField.isUserInteractionEnabled = false
        conversionCurrencyTextField.textColor = .gray
        view.addSubview(conversionCurrencyTextField)
        conversionCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conversionCurrencyTextField.topAnchor.constraint(equalTo: baseCurrencyTextField.bottomAnchor, constant: 25),
            conversionCurrencyTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            conversionCurrencyTextField.widthAnchor.constraint(equalToConstant: 200),
            conversionCurrencyTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        conversionCurrencyLabel = UILabel(frame: .zero)
        conversionCurrencyLabel.textAlignment = .right
        view.addSubview(conversionCurrencyLabel)
        conversionCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conversionCurrencyLabel.centerYAnchor.constraint(equalTo: conversionCurrencyTextField.centerYAnchor, constant: 0),
            conversionCurrencyLabel.leftAnchor.constraint(equalTo: conversionCurrencyTextField.rightAnchor, constant: 10),
            conversionCurrencyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            conversionCurrencyLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        guard let viewModel = viewModel as? CurrencyConverterViewModel,
            let conversionCurrency = viewModel.conversionCurrency else { return }
        conversionCurrencyTextField.text = String(format: "%.2f", conversionCurrency.conversionRate)
        conversionCurrencyLabel.text = conversionCurrency.symbol
    }
    
    @objc private func didTapOnBackButton() {
        dismiss(animated: true,
                completion: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.coordinatorDelegate.dismiss()
                    
        })
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print(text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text,
            text.isEmpty,
            text.replacingOccurrences(of: " ", with: "").isEmpty {
            textField.text = "1.0"
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = ""
        return false
    }
}
