//
//  RateResponse.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation

struct RateResponse : Codable {
    
   private enum CodingKeys: String, CodingKey {
        case base
        case date
        case rates
        case success
    }

    let base : String?
    let date : String?
    let rates : [String:Float]?
    let success : Bool?
}
