//
//  CalculatorViewModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/21/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class CalculatorViewModel: BaseViewModel {
    
    var rate:Float
    
    let baseCurrency: BehaviorRelay<String> = BehaviorRelay(value: "")
    let selectedCurrency: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    let baseCountryImageURL: BehaviorRelay<String> = BehaviorRelay(value: "")
    let selectedCountryImageURL: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    let baseAmount: BehaviorRelay<String> = BehaviorRelay(value: "")
    let rateText: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    let numberFormatter = NumberFormatter()
    
    
    init(baseCurrency:String, selectedCurrency:String, selectedRate:Float) {
        self.baseCurrency.accept(baseCurrency)
        self.selectedCurrency.accept(selectedCurrency)
        self.rate = selectedRate
        super.init()
        commonInit()
    }
    
    func commonInit(){
        numberFormatter.numberStyle = .decimal
        baseCountryImageURL.accept(CountryFlagHelper.getFlagURLfor(currencyCode: baseCurrency.value))
        selectedCountryImageURL.accept(CountryFlagHelper.getFlagURLfor(currencyCode: selectedCurrency.value))
        loadInitialData()
    }
    
    func updateBaseAmountWith(text:String?){
        guard let text = text, let value = self.numberFormatter.number(from: text) else {
            rateText.accept("")
            return
        }
        rateText.accept("\(rate*value.floatValue)")
    }
    
    func loadInitialData(){
        baseAmount.accept("1")
        rateText.accept("\(rate)")
    }
    
}
