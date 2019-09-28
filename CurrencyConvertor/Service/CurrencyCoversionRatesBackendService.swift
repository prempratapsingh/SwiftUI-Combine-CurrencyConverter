//
//  CurrencyCoversionRatesBackendService.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrencyCoversionRatesBackendService: BackendService {
    func getCurrencyConversions(for currency: String,
                                responseHandler: @escaping CurrencyListResponseHandler,
                                errorHandler: @escaping ErrorHandler) {
        let parameters: [String: Any] = [
            "base": currency
        ]
        httpMethod = .get
        encoding = URLEncoding.default
        serviceUrl = BackendServiceURL.getQualifiedUrlForExchangeRatesAPI(for: BackendServiceConstants.EndPoint.coversionRates.value)
        super.request(
            parameters: parameters,
            responseHandler: { response in
                guard let response = response.result.value as? [String: Any],
                    let currenciesJSON = response["rates"] as? [String: Any] else {
                        errorHandler(ATCError.genericBackendError)
                        return
                }
                
                let worker = CurrencyDeserializationWorker(with: currenciesJSON)
                if let currencies = worker.deserilazeCurrencies(), currencies.count > 0 {
                    responseHandler(currencies)
                } else {
                    let error = ATCError(type: .noResults,
                                         code: 0,
                                         description: "Oops! Something went wrong, couldn't load the currencies.")
                    errorHandler(error)
                }
            },
            errorHandler: { error in
                errorHandler(error)
        })
    }
}
