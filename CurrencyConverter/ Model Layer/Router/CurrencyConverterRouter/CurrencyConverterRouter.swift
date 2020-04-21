//
//  CurrencyConverterRouter.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation
import Alamofire

enum CurrencyConverterEndPoint {
    case getSupportedSymbols
    case getLatestRates(base: String)
}

class CurrencyConverterRouter:BaseRouter {
    var endPoint:CurrencyConverterEndPoint
    
    init(endPoint:CurrencyConverterEndPoint) {
        self.endPoint = endPoint
    }
    
    override var method: HTTPMethod{
        switch endPoint {
        case .getSupportedSymbols,
             .getLatestRates:
            return .get
        }
    }
    
    override var path: String{
        switch endPoint {
        case .getSupportedSymbols:
            return "/symbols"
        case .getLatestRates:
            return "/latest"
        }
    }
    
    override var encoding: ParameterEncoding?{
        
        switch method {
        case .post:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    override var parameters: APIParams{
        switch endPoint {
        case .getSupportedSymbols:
            return ["access_key":EnviromentManager.shared.fixerAccessKey as AnyObject]
        case .getLatestRates(_):
            return [/*"base":base as AnyObject,*/
                    "access_key":EnviromentManager.shared.fixerAccessKey as AnyObject]
        }
    }
}
