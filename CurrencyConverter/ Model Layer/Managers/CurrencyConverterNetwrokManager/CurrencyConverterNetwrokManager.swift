//
//  CurrencyConverterNetwrokManager.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import RxSwift

class CurrencyConverterNetwrokManager: BaseNetworkManager {
    
    func getSupportedSymbols() -> Single<SupportedSymbolResponse> {
        return Single<SupportedSymbolResponse>.create { single in
            let router = CurrencyConverterRouter(endPoint: .getSupportedSymbols)
            super.performNetworkRequest(forRouter: router, onSuccess: { (json) in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let symbolsResponse = try decoder.decode(SupportedSymbolResponse.self, from: jsonData)
                    single(.success(symbolsResponse))
                    return
                } catch {
                    single(.error(APIError()))
                    return
                }
                
            }) { (apiError) in
                single(.error(APIError()))
                return
            }
            return Disposables.create()
        }
    }
    
    func getRates(base:String) -> Single<RateResponse> {
        return Single<RateResponse>.create { single in
            let router = CurrencyConverterRouter(endPoint: .getLatestRates(base: base))
            super.performNetworkRequest(forRouter: router, onSuccess: { (json) in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let symbolsResponse = try decoder.decode(RateResponse.self, from: jsonData)
                    single(.success(symbolsResponse))
                    return
                } catch {
                    single(.error(APIError()))
                    return
                }
            }) { (apiError) in
                single(.error(APIError()))
                return
            }
            return Disposables.create()
        }
    }
    
}

