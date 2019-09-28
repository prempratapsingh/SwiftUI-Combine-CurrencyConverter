//
//  ATCError.swift
//  CurrencyConverter-PremPratapSingh
//
//  Created by Prem Pratap Singh on 19/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

enum ATCErrorType: String {
    case defaultError = "DefaultError"
    case networkError = "NetworkError"
    case unauthorizedError = "UnauthorizedError"
    case badRequestError = "BadRequestError"
    case notFoundError = "NotFoundError"
    case forbiddenError = "ForbiddenError"
    case validationError = "ValidationError"
    case internalServerError = "InternalServerError"
    case noResults = "NoResults"
    case unableToParseResponse = "UnableToParseResponse"
    case conflictError = "ConflictError"
}

class ATCError: Error {
    var code: Int = 0
    var type: ATCErrorType = .defaultError
    var description = ""
    var errorInfo: [String: Any]?
    
    static var genericBackendError: ATCError {
        let message = "Generic backend error text"
        let error = ATCError(type: .defaultError, code: 0, description: message)
        return error
    }
    
    init(type: ATCErrorType, code: Int, description: String, errorInfo: [String: Any]? = nil) {
        self.type = type
        self.code = code
        self.description = description
        self.errorInfo = errorInfo
    }
}
