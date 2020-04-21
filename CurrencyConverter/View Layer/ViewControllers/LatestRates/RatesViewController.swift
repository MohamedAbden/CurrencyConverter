
//
//  RatesViewController.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
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
    
    init(viewModel:RatesViewModel) {
         super.init(nibName:RatesViewController.identifier, bundle: nil)
         self.baseViewModel = viewModel
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBindings()
        viewModel.configureSymbols()
    }
    
    override func configureBindings() {
        super.configureBindings()
        configureNavigationBindings()
        configureHeaderBinding()
        
        //fix tableview load warning
        DispatchQueue.main.async { [unowned self] in
            self.configureTableViewBinding()
        }
    }
    
    func configureNavigationBindings(){
        viewModel.showSymbolsPickerSubject.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (viewModel) in
            guard let self = self else { return }
            let viewController = SymbolsPickerViewController(viewModel: viewModel)
            self.present(viewController, animated: true, completion: nil)
        }).disposed(by: bag)
        
        viewModel.showCalculatorSubject.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (viewModel) in
            guard let self = self else { return }
            let viewController = CalculatorViewController(viewModel: viewModel)
            self.present(viewController, animated: true, completion: nil)
        }).disposed(by: bag)
    }
    
    func configureUI(){
        self.navigationController?.navigationBar.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectedCountryAction))
        selectedCountryView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleSelectedCountryAction(){
        viewModel.handleActionForSelectedSymbol()
    }
}

extension RatesViewController {
    
    func configureTableViewBinding(){
        tableView.register(UINib(nibName: RateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RateTableViewCell.identifier)
        
        viewModel.ratesdataSource
            .observeOn(MainScheduler.instance)
            .bind(to: tableView
                .rx
                .items(cellIdentifier: RateTableViewCell.identifier, cellType: RateTableViewCell.self)) {
                    rowIndex, cellViewModel, cell in
                    cell.baseViewModel = cellViewModel
        }
        .disposed(by: bag)
        
        tableView
            .rx
            .modelSelected(RateCellViewModel.self)
            .subscribe(onNext: { [unowned self] cellViewModel in
                self.viewModel.handleSelectionFor(cellViewModel: cellViewModel)
            })
            .disposed(by: bag)
    }
    
    func configureHeaderBinding(){
        viewModel.selectedSymbolSubject.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (currencyCellViewModel) in
            guard let self = self else { return }
            let url = URL(string: currencyCellViewModel.countryImageURL)
            self.selectedCountryImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_flagPlaceholder"), options: .highPriority, context: nil)
            self.selectedCountryLabel.text = currencyCellViewModel.currency
        }).disposed(by: bag)
    }
}
