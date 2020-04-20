

//
//  BaseNetworkManager.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//


import Alamofire


typealias NetworkManagerRequest = DataRequest

class BaseNetworkManager: NSObject {
    
    typealias SuccessCompletion = (Any) -> Void
    
    typealias FailureCompletion = (Error) -> Void
    
    @discardableResult
    func performNetworkRequest(forRouter router: BaseRouter , onSuccess: @escaping SuccessCompletion , onFailure: @escaping FailureCompletion) -> DataRequest {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "http://data.fixer.io/" : .performDefaultEvaluation(validateHost: true)
        ]
        let sessionManager = Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        print("----- (router) ", (router) as Any)
        
        let request = sessionManager.request(router)
            .validate()
            .responseJSON { (response) in
                sessionManager.session.invalidateAndCancel()
                
                switch response.result
                {
                case .success( _):
                    return onSuccess(response.result.value!)
                case .failure(let error):
                    return onFailure(error)
                }
        }
        return request
    }
}

