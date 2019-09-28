//
//  CurrencyListBackendService.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrencyListBackendService: BackendService {
    
    func getCurrencyList(responseHandler: @escaping CurrencyListResponseHandler,
                         errorHandler: @escaping ErrorHandler) {
        let parameters: [String: Any] = [
            "access_key": "f46a7248841eb9d9217cbe5c4e57a1f0",
            "format": 1
        ]
        httpMethod = .get
        encoding = URLEncoding.default
        super.request(
            parameters: parameters,
            responseHandler: { response in
                guard let response = response.result.value as? [String: Any],
                    let currenciesJSON = response["symbols"] as? [String: Any] else {
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
