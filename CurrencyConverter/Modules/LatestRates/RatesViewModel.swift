//
//  RatesViewModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class RatesViewModel: BaseViewModel {
    
    override var viewControllerIdentifier: String{
        return RatesViewController.identifier
    }
    
    let ratesdataSource: BehaviorRelay<[RateCellViewModel]> = BehaviorRelay(value: [])
    let symbolsdataSource: BehaviorRelay<[CurrencyCellViewModel]> = BehaviorRelay(value: [])
    var selectedCurrencySubject = PublishSubject<CurrencyCellViewModel>()
    let networkManager = CurrencyConverterNetwrokManager()
    var selectedCurrency:CurrencyCellViewModel?
    
    override init() {
        super.init()
        configureBindings()
    }
    
    func configureSymbols(){
        self.showLoading(loadingType: .Placeholder)
        networkManager.getSupportedSymbols().subscribe(
            onSuccess: { [weak self] (SymbolsResponse) in
                guard let self = self else { return }
                self.configureSymbolsDataSource(symbolsResponse: SymbolsResponse)
            },
            onError: { [weak self] (apiError) in
                guard let self = self else { return }
                self.hideLoading(loadingType: .Placeholder)
                let emptyStateViewModel = EmptyStateViewModel(title: "an error has occurred", description: nil, imageName: nil, buttonTitle: nil)
                self.showEmptyStateWith(viewModel: emptyStateViewModel)
        }).disposed(by: bag)
    }
    
    private func configureBindings(){
        selectedCurrencySubject.asObservable().subscribe(onNext: { [weak self] (currencyCellViewModel) in
            guard let self = self else { return }
            self.configureRatesWith(selectedCurrency: currencyCellViewModel)
            self.selectedCurrency = currencyCellViewModel
        }).disposed(by: bag)
    }
    
    private func configureRatesWith(selectedCurrency:CurrencyCellViewModel){
        networkManager.getRates(base: selectedCurrency.currency).subscribe(
            onSuccess: { [weak self] (rateResponse) in
                guard let self = self else { return }
                self.configureRatesDataSource(rateResponse: rateResponse)
                self.hideLoading(loadingType: .Placeholder)
            },
            onError: { [weak self] (apiError) in
                guard let self = self else { return }
                self.hideLoading(loadingType: .Placeholder)
                let emptyStateViewModel = EmptyStateViewModel(title: "an error has occurred", description: nil, imageName: nil, buttonTitle: nil)
                self.showEmptyStateWith(viewModel: emptyStateViewModel)
        }).disposed(by: bag)
    }
    
    private func configureSymbolsDataSource(symbolsResponse:SupportedSymbolResponse){
        guard let symbols = symbolsResponse.symbols else {
            let emptyStateViewModel = EmptyStateViewModel(title: "No Data", description: nil, imageName: nil, buttonTitle: nil)
            self.showEmptyStateWith(viewModel: emptyStateViewModel)
            return
        }
        
        let cellviewModels  = symbols.keys.compactMap { (currency) -> CurrencyCellViewModel? in
            let name = symbols[currency] ?? ""
            return CurrencyCellViewModel(currency: currency, name: name)
        }
        
        let usdCellViewModel = cellviewModels.first(where: { (cellViewModel) -> Bool in
            return cellViewModel.currency.lowercased() == "usd"
        })
        if let usdCellViewModel = usdCellViewModel {
            selectedCurrencySubject.onNext(usdCellViewModel)
        }
        symbolsdataSource.accept(cellviewModels)
    }
    
    private func configureRatesDataSource(rateResponse:RateResponse){
        guard let rates = rateResponse.rates else {
            let emptyStateViewModel = EmptyStateViewModel(title: "No Data", description: nil, imageName: nil, buttonTitle: nil)
            self.showEmptyStateWith(viewModel: emptyStateViewModel)
            return
        }
        
        let cellviewModels  = rates.keys.sorted().compactMap { (currency) -> RateCellViewModel? in
            let rate = String(rates[currency] ?? 0)
            return RateCellViewModel(currency: currency, rate: rate )
        }
        
        ratesdataSource.accept(cellviewModels)
    }
    
}
