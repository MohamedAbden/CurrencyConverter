//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var cellViewModel:CurrencyCellViewModel?
    override var baseViewModel: BaseCellViewModel?{
        didSet{
            cellViewModel = baseViewModel as? CurrencyCellViewModel
            bindUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindUI(){
        
    }
    
}
