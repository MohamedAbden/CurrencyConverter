//
//  CountryFlagHelper.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation

class CountryFlagHelper {
    static func getFlagURLfor(code:String,size:Int = 80) -> String{
        return "https://www.countryflags.io/\(code)/flat/\(64).png"
    }
}
