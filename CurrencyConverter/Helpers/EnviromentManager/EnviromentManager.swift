//
//  EnviromentManager.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation

class EnviromentManager {
    
    static var shared = EnviromentManager()
    
    var fixerBaseURL: String {
        get{
            return  "http://data.fixer.io/api"
        }
    }
    
    var fixerAccessKey: String{
        get{
            return  "fd53bb3fa4e7430e0383d808704528d1"
        }
    }
}


