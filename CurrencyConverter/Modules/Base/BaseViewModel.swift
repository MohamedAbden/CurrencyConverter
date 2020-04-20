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
    
    
    let viewControllerIdentifie:String! = ""
    
    var isLoading:Bool = false
    
    let bag = DisposeBag()
    
    let pushViewControllerSubject = PublishSubject<BaseViewModel>()
    let popViewControllerSubject = PublishSubject<Bool>()
    
    let presentViewControllerSubject = PublishSubject<BaseViewModel>()
    let dismissViewControllerSubject = PublishSubject<(animated: Bool, complition: (() -> Void)?)>()
    
    let showLoadingSubject = PublishSubject<LoadingType>()
    let hideLoadingSubject = PublishSubject<LoadingType>()
    
    var showEmptyStateSubject = PublishSubject<EmptyStateViewModel>()
    var hideEmptyStateSubject = PublishSubject<Void>()
    
    var pushViewController: Observable<BaseViewModel> {
        return pushViewControllerSubject.asObservable()
    }
    
    var popViewController: Observable<Bool> {
        return popViewControllerSubject.asObservable()
    }
    
    var presentViewController: Observable<BaseViewModel> {
        return presentViewControllerSubject.asObservable()
    }
    
    var dismissViewController: Observable<(animated: Bool, complition: (() -> Void)?)> {
        return dismissViewControllerSubject.asObservable()
    }
    
    var showLoading: Observable<LoadingType> {
        return showLoadingSubject.asObservable()
    }
    
    var hideLoading: Observable<LoadingType> {
        return hideLoadingSubject.asObservable()
    }
    
    var showEmptyState: Observable<EmptyStateViewModel> {
        return showEmptyStateSubject.asObservable()
    }
    
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
}
