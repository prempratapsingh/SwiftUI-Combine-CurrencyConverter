//
//  CurrencyCodeView.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 20/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

class CurrencyCodeView: UIView {
    static let identifier = "CurrencyCodeView"
    
    private var currency: Currency!
    private var iconImage: UIImageView!
    private var symbolLabel: UILabel!
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        configureView()
    }
    
    func configure(with currency: Currency) {
        self.currency = currency
    }
    
    private func configureView() {
        let bgColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        backgroundColor = bgColor
        layer.backgroundColor = bgColor.cgColor
        configureIconImage()
        configureCodeLabel()
        configureTitleLabel()
    }
    
    private func configureIconImage() {
        iconImage = UIImageView(frame: .zero)
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
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
        symbolLabel.textColor = .white
        symbolLabel.text = ""
        if let currency = currency {
            symbolLabel.text = currency.symbol
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: symbolLabel.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: symbolLabel.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        titleLabel.textColor = .white
        titleLabel.text = ""
        if let currency = currency {
            titleLabel.text = currency.title
        }
    }
}
