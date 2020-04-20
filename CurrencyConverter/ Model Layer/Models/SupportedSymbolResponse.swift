//
//  SupportedSymbolResponse.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//


import Foundation

struct SupportedSymbolResponse : Codable {
    
    enum CodingKeys: String, CodingKey {
        case success
        case symbols
    }

    let success : Bool?
    let symbols : [String:String]?
}
