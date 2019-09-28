//
//  TypeAliases.swift
//  CurrencyConvertor
//
//  Created by Prem Pratap Singh on 28/09/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation
import Alamofire

typealias VoidCompletionHandler = () -> Void
typealias BoolCompletionHandler = (Bool) -> Void
typealias CurrencyListResponseHandler = ([Currency]) -> Void
typealias ResponseHandler = (DataResponse<Any>) -> Void
typealias ErrorHandler = (ATCError) -> Void
