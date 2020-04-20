
//
//  RateCellViewModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit

class RateCellViewModel: BaseCellViewModel {
    
    override var cellIdentifier: String{
        return RateTableViewCell.identifier
    }
    
    var countryImageURL:String = ""
    var rate:String = ""
    var currency:String = ""
    
    init(currency:String,rate:String) {
        self.rate = rate
        self.currency = currency
        super.init()
        configureCountryFlagURL()
    }
    
    func configureCountryFlagURL(){
        let code = String(currency.dropLast())
        self.countryImageURL = CountryFlagHelper.getFlagURLfor(code: code)
    }
}
