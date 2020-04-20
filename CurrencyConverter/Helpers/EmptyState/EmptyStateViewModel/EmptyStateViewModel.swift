//
//  EmptyStateViewModel.swift
//  TawkeelPRO
//
//  Created by Mohamed Abd el-latef on 1/12/19.
//  Copyright © 2019 Mohamed Abd el-latef. All rights reserved.
//

import Foundation

enum EmptyStateViewType: Int
{
    case Loading = 1
    case Default = 2
}

class EmptyStateViewModel: NSObject {
    var type:EmptyStateViewType!
    var title:String?
    var stateDescription:String?
    var imageName:String?
    var buttonTitle:String?
    
    var buttonActionClosure: (() -> Void)?
    
    init(type:EmptyStateViewType) {
        self.type = type
    }
    
    init(title:String? = nil, description:String? = nil,imageName:String? = nil,buttonTitle:String? = nil) {
        self.type = .Default
        self.title = title
        self.stateDescription = description
        self.imageName = imageName
        self.buttonTitle = buttonTitle
    }
    
    func buttonAction() {
        if let buttonActionClosure = buttonActionClosure {
            buttonActionClosure()
        }
    }
}
