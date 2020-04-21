//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/21/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class CalculatorViewController: BaseViewController {
    
    private var viewModel:CalculatorViewModel!
    override var baseViewModel: BaseViewModel!{
        didSet{
            self.viewModel = baseViewModel as? CalculatorViewModel
        }
    }
    
    @IBOutlet weak var baseCountryImageView: UIImageView!
    @IBOutlet weak var baseRateTextField: UITextField!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var selectedCurrencyLabel: UILabel!
    @IBOutlet weak var selectedCountryImageView: UIImageView!
    
    init(viewModel:CalculatorViewModel) {
        super.init(nibName:CalculatorViewController.identifier, bundle: nil)
        self.baseViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        baseRateTextField.becomeFirstResponder()
    }
    
    override func configureBindings() {
        super.configureBindings()
        
        viewModel.baseCurrency.asObservable().bind(to: baseCurrencyLabel.rx.text).disposed(by: bag)
        viewModel.selectedCurrency.asObservable().bind(to: selectedCurrencyLabel.rx.text).disposed(by: bag)
        
        viewModel.baseCountryImageURL.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (urlString) in
            guard let self = self else { return }
            let url  = URL(string: urlString)
            self.baseCountryImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_flagPlaceholder"), options: .highPriority, context: nil)
        }).disposed(by: bag)
        viewModel.selectedCountryImageURL.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (urlString) in
            guard let self = self else { return }
            let url  = URL(string: urlString)
            self.selectedCountryImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_flagPlaceholder"), options: .highPriority, context: nil)
        }).disposed(by: bag)
        
        
        viewModel.rateText.asObservable().bind(to: totalAmountLabel.rx.text).disposed(by: bag)
        viewModel.baseAmount.asObservable().bind(to: baseRateTextField.rx.text).disposed(by: bag)
        baseRateTextField.rx.text.asObservable().subscribe(onNext: { [weak self] (text) in
            guard let self = self else { return }
            self.viewModel.updateBaseAmountWith(text: text)
        }).disposed(by: bag)
    }
}
