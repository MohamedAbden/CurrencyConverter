
//
//  RateCellViewModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation

class RateCellViewModel: BaseCellViewModel {
    
    var countryImageURL:String = ""
    var rateText:String = ""
    var rate:Float
    var currency:String
    
    init(currency:String,rate:Float) {
        self.rate = rate
        self.rateText = "\(rate)"
        self.currency = currency
        super.init()
        configureCountryFlagURL()
    }
    
    func configureCountryFlagURL(){
        self.countryImageURL = CountryFlagHelper.getFlagURLfor(currencyCode: currency)
    }
}
