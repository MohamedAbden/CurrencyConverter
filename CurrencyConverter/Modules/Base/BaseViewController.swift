//
//  BaseViewController.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    var baseViewModel:BaseViewModel!
    let bag = DisposeBag()
    var emptyStateView:EmptyStateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func configureBindings() {
        baseViewModel.pushViewController.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (viewModel) in
                guard let self = self else { return }
                let viewController = UIViewController.init(nibName: viewModel.viewControllerIdentifier, bundle: nil)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: bag)
        
        
        baseViewModel.popViewController.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (animated) in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: animated)
            })
            .disposed(by: bag)
        
        baseViewModel.presentViewController.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (viewModel) in
                guard let self = self else { return }
                let viewController = UIViewController.init(nibName: viewModel.viewControllerIdentifier, bundle: nil)
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        baseViewModel.dismissViewController.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (animated, complition) in
                guard let self = self else { return }
                self.dismiss(animated: animated, completion: complition)
            })
            .disposed(by: bag)
        
        
        baseViewModel.showLoading.observeOn(MainScheduler.instance)
            .subscribe(onNext: { (loadingType) in
                if loadingType == .Default {
                    let activityData = ActivityData(color: .blue )
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData,nil)
                }
            })
            .disposed(by: bag)
        
        baseViewModel.hideLoading.observeOn(MainScheduler.instance)
            .subscribe(onNext: {(loadingType) in
                if loadingType == .Default {
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                }
            })
            .disposed(by: bag)
        
        baseViewModel.showEmptyStateSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (emptyStateViewModel) in
                guard let self  = self else { return }
                self.emptyStateView = EmptyStateView.emptyStateView(viewModel: emptyStateViewModel, frame: self.view.bounds)
                self.view.addSubview(self.emptyStateView!)
            })
            .disposed(by: bag)
        
        
        baseViewModel.hideEmptyStateSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self  = self else { return }
                self.emptyStateView?.removeFromSuperview()
                self.emptyStateView = nil
            })
            .disposed(by: bag)
    }
}
