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
      
    @IBOutlet weak var baseCountryImageURL: UIImageView!
    @IBOutlet weak var baseRateTextField: UITextField!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var selectedCurrencyLabel: UILabel!
    @IBOutlet weak var selectedCountryImageView: UIImageView!
    
    init(viewModel:BaseViewModel) {
        super.init(nibName:CalculatorViewController.identifier, bundle: nil)
        self.baseViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        bindUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        baseRateTextField.becomeFirstResponder()
    }
        
    override func configureBindings() {
        super.configureBindings()
        
    }
    
    func bindUI(){
        baseCurrencyLabel.text = viewModel.baseCurrency
        selectedCurrencyLabel.text = viewModel.selectedCurrency
        
        
    }
}
