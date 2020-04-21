//
//  SymbolsPickerViewController.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit

class SymbolsPickerViewController: BaseViewController {

    private var viewModel:SymbolsPickerViewModel!
    override var baseViewModel: BaseViewModel!{
        didSet{
            self.viewModel = baseViewModel as? SymbolsPickerViewModel
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel:SymbolsPickerViewModel) {
        super.init(nibName: SymbolsPickerViewController.identifier, bundle: nil)
        self.baseViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        DispatchQueue.main.async { [unowned self] in
            self.configureTableViewBinding()
            self.configureTableViewSelection()
        }
    }
}

extension SymbolsPickerViewController {
    
    func configureTableViewBinding(){
        tableView.register(UINib(nibName: SymbolTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SymbolTableViewCell.identifier)
        
        viewModel.symbolsdataSource
            .bind(to: tableView
                .rx
                .items(cellIdentifier: SymbolTableViewCell.identifier, cellType: SymbolTableViewCell.self)) {
                    rowIndex, cellViewModel, cell in
                    cell.baseViewModel = cellViewModel
        }
        .disposed(by: bag)
    }
    
    func configureTableViewSelection() {
      tableView
        .rx
        .modelSelected(SymbolCellViewModel.self)
        .subscribe(onNext: { [unowned self] cellViewModel in
            self.viewModel.handleSelectionfor(cellViewModel: cellViewModel)
        })
        .disposed(by: bag)
    }
}

