
//
//  EmptyStateView.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EmptyStateView: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var defaultEmptyStateView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    
    static func emptyStateView(viewModel:EmptyStateViewModel,frame:CGRect) -> EmptyStateView{
        if let view = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.last as? EmptyStateView{
            view.frame = frame
            view.viewModel = viewModel
            return view
        }
        return EmptyStateView()
    }
    
    static func loadingEmptyStateView(frame:CGRect) -> EmptyStateView{
        if let view = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.last as? EmptyStateView{
            view.frame = frame
            view.viewModel = EmptyStateViewModel(type: .Loading)
            return view
        }
        return EmptyStateView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    
    
    //MARK:- Variables
    var viewModel:EmptyStateViewModel!{
        didSet{
            bindUI()
        }
    }
    
    //MARK:- Helper Methods
    func configureUI(){
        backgroundColor = .white
        loadingLabel.text = "Loading..."
    }
    
    func bindUI(){
        if (viewModel.type == .Loading){
            configureLoadingView()
        }
        else{
            configureDefaultView()
        }
    }
    
    func configureLoadingView(){
        self.defaultEmptyStateView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func configureDefaultView(){
        self.loadingView.isHidden = true
        
        if let imageName = viewModel.imageName{
            imageView.image = UIImage(named: imageName)
        }
        else{
            imageView.isHidden = true
        }
        
        if let title = viewModel.title{
            titleLabel.text = title
        }
        else{
            titleLabel.isHidden = true
        }
        
        if let description = viewModel.stateDescription{
            descriptionLabel.text = description
        }
        else{
            descriptionLabel.isHidden = true
        }
        
        if let buttonTitle = viewModel.buttonTitle{
            button.setTitle(buttonTitle, for: .normal)
        }
        else{
            button.isHidden = true
        }
    }
    
    //MARK:- Actions
    @IBAction func buttonAction(_ sender: Any) {
        viewModel.buttonAction()
    }
}
