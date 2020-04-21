//
//  BaseViewModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class BaseViewModel: NSObject {
    
    var isLoading:Bool = false
    
    let bag = DisposeBag()
    
    let showLoadingSubject = PublishSubject<LoadingType>()
    let hideLoadingSubject = PublishSubject<LoadingType>()
    
    var showEmptyStateSubject = PublishSubject<EmptyStateViewModel>()
    var hideEmptyStateSubject = PublishSubject<Void>()
    
    var popViewControllerSubject = PublishSubject<Void>()
    var dismissViewControllerSubject = PublishSubject<Void>()
    
    func showLoading(loadingType:LoadingType){
        if !isLoading {
            if loadingType == .Default{
                self.showLoadingSubject.onNext(.Default)
            }
            else if loadingType == .Placeholder{
                self.showEmptyStateSubject.onNext(EmptyStateViewModel(type: .Loading))
            }
            self.isLoading = true
        }
    }
    
    func showEmptyStateWith(viewModel:EmptyStateViewModel){
        self.showEmptyStateSubject.onNext(viewModel)
    }
    
    func hideLoading(loadingType:LoadingType){
        if loadingType == .Default{
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
        else if loadingType == .Placeholder{
            hideEmptyStateSubject.onNext(())
        }
        self.isLoading = false
    }
    
    func hideEmptyState(){
        hideEmptyStateSubject.onNext(())
    }
    
    func popView(){
        popViewControllerSubject.onNext(())
    }
    
    func dismissView(){
        dismissViewControllerSubject.onNext(())
    }
}
