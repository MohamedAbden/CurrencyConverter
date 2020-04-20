//
//  SymbolCellViewModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit

class CurrencyCellViewModel: BaseCellViewModel {
    
    override var cellIdentifier: String{
        return CurrencyTableViewCell.identifier
    }
    
    var countryImageURL:String = ""
    var currency:String = ""
    var name:String = ""
    
    init(currency:String,name:String) {
        self.currency = currency
        self.name = name
        super.init()
        configureCountryFlagURL()
    }
    
    func configureCountryFlagURL(){
        let code = String(currency.dropLast())
        self.countryImageURL = CountryFlagHelper.getFlagURLfor(code: code)
    }
}
