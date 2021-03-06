//
//  RatesViewModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class RatesViewModel: BaseViewModel {
    
    let ratesdataSource: BehaviorRelay<[RateCellViewModel]> = BehaviorRelay(value: [])
    let symbolsdataSource: BehaviorRelay<[SymbolCellViewModel]> = BehaviorRelay(value: [])
    var selectedSymbolSubject = PublishSubject<SymbolCellViewModel>()
    let networkManager = CurrencyConverterNetwrokManager()
    var showSymbolsPickerSubject = PublishSubject<SymbolsPickerViewModel>()
    var showCalculatorSubject = PublishSubject<CalculatorViewModel>()
    var selectedSymbolCellViewModel :SymbolCellViewModel?
    
    
    override init() {
        super.init()
        configureBindings()
    }
    
    func configureSymbols(){
        self.showLoading(loadingType: .Placeholder)
        networkManager.getSupportedSymbols().subscribe(
            onSuccess: { [weak self] (SymbolsResponse) in
                guard let self = self else { return }
                self.hideLoading(loadingType: .Placeholder)
                self.configureSymbolsDataSource(symbolsResponse: SymbolsResponse)
            },
            onError: { [weak self] (apiError) in
                guard let self = self else { return }
                self.hideLoading(loadingType: .Placeholder)
                self.showErrorEmptyState()
        }).disposed(by: bag)
    }
    
    private func configureBindings(){
        selectedSymbolSubject.asObservable().subscribe(onNext: { [weak self] (currencyCellViewModel) in
            guard let self = self else { return }
            self.configureRatesWith(selectedCurrency: currencyCellViewModel)
            currencyCellViewModel.isSelected.accept(true)
            self.selectedSymbolCellViewModel = currencyCellViewModel
        }).disposed(by: bag)
    }
    
    private func configureRatesWith(selectedCurrency:SymbolCellViewModel){
        showLoading(loadingType: .Placeholder)
        networkManager.getRates(base: selectedCurrency.currency).subscribe(
            onSuccess: { [weak self] (rateResponse) in
                guard let self = self else { return }
                self.hideLoading(loadingType: .Placeholder)
                self.configureRatesDataSource(rateResponse: rateResponse)
            },
            onError: { [weak self] (apiError) in
                guard let self = self else { return }
                self.hideLoading(loadingType: .Placeholder)
                self.showErrorEmptyState()
        }).disposed(by: bag)
    }
    
    private func configureSymbolsDataSource(symbolsResponse:SupportedSymbolResponse){
        guard let symbols = symbolsResponse.symbols else {
            let emptyStateViewModel = EmptyStateViewModel(title: "No Data", description: nil)
            self.showEmptyStateWith(viewModel: emptyStateViewModel)
            return
        }
        
        let cellviewModels  = symbols.keys.sorted().compactMap { (currency) -> SymbolCellViewModel? in
            let name = symbols[currency] ?? ""
            return SymbolCellViewModel(currency: currency, name: name)
        }
        
        let usdCellViewModel = cellviewModels.first(where: { (cellViewModel) -> Bool in
            return cellViewModel.currency.lowercased() == "usd"
        })
        if let usdCellViewModel = usdCellViewModel {
            selectedSymbolSubject.onNext(usdCellViewModel)
        }
        symbolsdataSource.accept(cellviewModels)
    }
    
    private func configureRatesDataSource(rateResponse:RateResponse){
        guard let rates = rateResponse.rates else {
            let emptyStateViewModel = EmptyStateViewModel(title: "No Data", description: nil)
            self.showEmptyStateWith(viewModel: emptyStateViewModel)
            return
        }
        
        let cellviewModels  = rates.keys.sorted().compactMap { [weak self] (currency) -> RateCellViewModel? in
            guard let self = self else { return nil }
            if self.selectedSymbolCellViewModel?.currency == currency {
                return nil
            }
            else{
                return RateCellViewModel(currency: currency, rate: rates[currency] ?? 0)
            }
        }
        ratesdataSource.accept(cellviewModels)
    }
    
    func handleActionForSelectedSymbol(){
        let pickerViewModel = SymbolsPickerViewModel(dataSource: symbolsdataSource)
        pickerViewModel.selectedSymbol.subscribe(onNext: { [unowned self] (selectedCellviewModel) in
            self.selectedSymbolSubject.onNext(selectedCellviewModel)
        }).disposed(by: bag)
        showSymbolsPickerSubject.onNext(pickerViewModel)
    }
    
    func handleSelectionFor(cellViewModel:RateCellViewModel){
        guard let symbolCellViewModel = selectedSymbolCellViewModel else {
            return
        }
        let calculatorViewModel = CalculatorViewModel(baseCurrency: symbolCellViewModel.currency, selectedCurrency: cellViewModel.currency, selectedRate: cellViewModel.rate)
        showCalculatorSubject.onNext(calculatorViewModel)
    }
    
    func showErrorEmptyState(){
        let emptyStateViewModel = EmptyStateViewModel(title: "an error has occurred", description: nil)
        self.showEmptyStateWith(viewModel: emptyStateViewModel)
    }
    
}
