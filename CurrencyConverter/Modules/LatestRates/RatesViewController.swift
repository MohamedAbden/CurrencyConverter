
//
//  RatesViewController.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit
import SDWebImage
import RxCocoa

class RatesViewController: BaseViewController {
    
    private var viewModel:RatesViewModel!
    override var baseViewModel: BaseViewModel!{
        didSet{
            self.viewModel = baseViewModel as? RatesViewModel
        }
    }
    
    @IBOutlet weak var selectedCountryView: UIStackView!
    @IBOutlet weak var selectedCountryImageView: UIImageView!
    @IBOutlet weak var selectedCountryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        configureBindings()
        viewModel.configureSymbols()
    }
    
    override func configureBindings() {
        super.configureBindings()
        configureHeaderBinding()
        configureTableViewBinding()
    }
    
    func configureTableViewBinding(){
        tableView.register(UINib(nibName: RateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RateTableViewCell.identifier)
        
        viewModel.ratesdataSource
            .bind(to: tableView
                .rx
                .items(cellIdentifier: RateTableViewCell.identifier, cellType: RateTableViewCell.self)) {
                    rowIndex, cellViewModel, cell in
                    cell.baseViewModel = cellViewModel
        }
        .disposed(by: bag)
    }
    
    func configureHeaderBinding(){
        viewModel.selectedCurrencySubject.subscribe(onNext: { [weak self] (currencyCellViewModel) in
            guard let self = self else { return }
            let url = URL(string: currencyCellViewModel.countryImageURL)
            self.selectedCountryImageView.sd_setImage(with: url, placeholderImage: UIImage(named: ""), options: .highPriority, context: nil)
        }).disposed(by: bag)
    }
    
}
