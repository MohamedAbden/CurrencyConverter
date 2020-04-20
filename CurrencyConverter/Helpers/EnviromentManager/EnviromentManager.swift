//
//  EnviromentManager.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation

enum EnviromentLocale : Int {
    case english
    case arabic
}

class EnviromentManager
{
    
    private var currentEnviromentLocale : EnviromentLocale = .english
    
    static var shared = EnviromentManager()
    
    var fixerBaseURL : String {
        get{
            return  "http://data.fixer.io/api/"
        }
    }
}


