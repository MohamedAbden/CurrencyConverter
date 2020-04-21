//
//  SymbolTableViewCell.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit
import RxSwift

class SymbolTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var bag = DisposeBag()
    
    var cellViewModel:SymbolCellViewModel?
    override var baseViewModel: BaseCellViewModel?{
        didSet{
            cellViewModel = baseViewModel as? SymbolCellViewModel
            bindUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func bindUI(){
        guard let viewModel = cellViewModel  else {
            return
        }
        let url = URL(string: viewModel.countryImageURL)
        countryImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_flagPlaceholder"), options: .highPriority, context: nil)
        nameLabel.text = viewModel.name
        viewModel.isSelected.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (isSelected) in
            guard let self = self else { return }
            self.accessoryType = isSelected ? .checkmark : .none
        }).disposed(by: bag)
        
    }
}
