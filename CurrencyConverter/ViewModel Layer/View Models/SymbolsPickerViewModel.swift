
//
//  SymbolsPickerViewModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class SymbolsPickerViewModel: BaseViewModel {

    let symbolsdataSource: BehaviorRelay<[SymbolCellViewModel]>
    var selectedSymbol = PublishSubject<SymbolCellViewModel>()
    
    init(dataSource:BehaviorRelay<[SymbolCellViewModel]>) {
        self.symbolsdataSource = dataSource
    }
    
    func handleSelectionfor(cellViewModel:SymbolCellViewModel){
        let oldCellViewModel = symbolsdataSource.value.first { (cellViewModel) -> Bool in
            return cellViewModel.isSelected.value
        }
        if let oldCellViewModel = oldCellViewModel {
            oldCellViewModel.isSelected.accept(false)
        }
        cellViewModel.isSelected.accept(true)
        selectedSymbol.onNext(cellViewModel)
        dismissView()
    }
}
