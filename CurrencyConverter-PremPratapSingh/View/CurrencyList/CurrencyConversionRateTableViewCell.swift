//
//  CurrencyConversionRateTableViewCell.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 20/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit
protocol CurrencyConversionRateTableViewCellDelegate: class {
    func didSelectCurrencyConverion(_ conversion: Currency)
}

class CurrencyConversionRateTableViewCell: UITableViewCell {
    static let identifier = "CurrencyConversionRateTableViewCell"
    weak var delegate: CurrencyConversionRateTableViewCellDelegate!
    
    private var currency: Currency!
    private var iconImage: UIImageView!
    private var symbolLabel: UILabel!
    private var conversionRateLabel: UILabel!
    
    private var tapGestureRecognizer: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(didTap))
    }
    
    override func draw(_ rect: CGRect) {
        let bgColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        backgroundColor = bgColor
        layer.backgroundColor = bgColor.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeGestureRecognizer(tapGestureRecognizer)
        currency = nil
        iconImage.image = nil
        symbolLabel.text = ""
        conversionRateLabel.text = ""
    }
    
    func configure(with currency: Currency) {
        self.currency = currency
        configureView()
    }
    
    private func configureView() {
        configureIconImage()
        configureCodeLabel()
        configureConversionRateLabel()
        configureGestureRecognizer()
    }
    
    private func configureIconImage() {
        iconImage = UIImageView(frame: .zero)
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            iconImage.heightAnchor.constraint(equalToConstant: 25),
            iconImage.widthAnchor.constraint(equalToConstant: 35)
            ])
        if let currency = currency,
            let image = UIImage(named: currency.symbol.lowercased()) {
            iconImage.image = image
        } else {
            iconImage.image = UIImage(named: "defaultFlag")
        }
    }
    
    private func configureCodeLabel() {
        symbolLabel = UILabel(frame: .zero)
        addSubview(symbolLabel)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: iconImage.topAnchor, constant: 0),
            symbolLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 10),
            symbolLabel.widthAnchor.constraint(equalToConstant: 50),
            symbolLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
        symbolLabel.textColor = .black
        symbolLabel.text = ""
        if let currency = currency {
            symbolLabel.text = currency.symbol
        }
    }
    
    private func configureConversionRateLabel() {
        conversionRateLabel = UILabel(frame: .zero)
        addSubview(conversionRateLabel)
        conversionRateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conversionRateLabel.topAnchor.constraint(equalTo: symbolLabel.topAnchor, constant: 0),
            conversionRateLabel.leftAnchor.constraint(equalTo: symbolLabel.rightAnchor, constant: 10),
            conversionRateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            conversionRateLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        conversionRateLabel.textAlignment = .right
        conversionRateLabel.textColor = .black
        conversionRateLabel.text = ""
        if let currency = currency {
            conversionRateLabel.text = String(format: "%.2f", currency.conversionRate)
        }
    }
    
    private func configureGestureRecognizer() {
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func didTap() {
        guard let currency = currency else { return }
        delegate.didSelectCurrencyConverion(currency)
    }
}
