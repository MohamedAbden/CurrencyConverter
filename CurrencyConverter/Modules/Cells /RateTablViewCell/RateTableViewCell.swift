
//
//  RateTableViewCell.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit

class RateTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    
    var cellViewModel:RateCellViewModel?
    override var baseViewModel: BaseCellViewModel?{
        didSet{
            cellViewModel = baseViewModel as? RateCellViewModel
            bindUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindUI(){
        guard let viewModel = cellViewModel  else {
            return
        }
        let url = URL(string: viewModel.countryImageURL)
        countryImageView.sd_setImage(with: url, placeholderImage: UIImage(named: ""), options: .highPriority, context: nil)
        currencyNameLabel.text = viewModel.currency
        rateLabel.text = viewModel.rate
    }
}
