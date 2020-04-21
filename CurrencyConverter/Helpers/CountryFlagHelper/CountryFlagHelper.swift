//
//  CountryFlagHelper.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation

class CountryFlagHelper {
    static func getFlagURLfor(currencyCode:String,size:Int = 64) -> String{
        let code = String(currencyCode.dropLast())
        return "https://www.countryflags.io/\(code)/flat/\(size).png"
    }
}
