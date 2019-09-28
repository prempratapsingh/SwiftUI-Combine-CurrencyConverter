//
//  BackendService.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import Alamofire

class BackendService: NSObject {
    var authenticationToken = ""
    var serviceUrl = ""
    var httpMethod: HTTPMethod = .get
    var encoding: ParameterEncoding = URLEncoding.default
    var httpHeaders: [String: String] = [
        BackendServiceConstants.HeaderName.contentType: BackendServiceConstants.HeaderValue.applicationJSON
    ]
    
    init(endPoint: String) {
        serviceUrl = BackendServiceURL.getQualifiedUrl(for: endPoint)
    }
    
    func addHeaderField(name: String, value: String) {
        httpHeaders[name] = value
    }
    
    func removeHeaderField(name: String) {
        httpHeaders[name] = nil
    }
    
    func request(parameters: [String: Any] = [:],
                 responseHandler: @escaping ResponseHandler,
                 errorHandler: @escaping ErrorHandler) {
        
        guard !serviceUrl.isEmpty else {
            let message = "Invalid backend URL error text"
            let error = ATCError(type: .defaultError, code: 0, description: message)
            errorHandler(error)
            return
        }
        
        Alamofire.request(serviceUrl,
                          method: httpMethod,
                          parameters: parameters,
                          encoding: encoding,
                          headers: httpHeaders).responseJSON { [weak self] response in
                            guard let stronSelf = self else { return }
                            if let error = response.error {
                                let atcError = stronSelf.getATCError(from: error)
                                errorHandler(atcError)
                                return
                            }
                            responseHandler(response)
        }
    }
    
    private func getATCError(from error: Error) -> ATCError {
        let atcError = ATCError(type: .defaultError, code: 0, description: error.localizedDescription)
        return atcError
    }
}
