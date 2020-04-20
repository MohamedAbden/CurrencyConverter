//
//  NSObject Extension.swift
//  CurrencyConverter
//
//  Created by Mohamed Abd el-latef on 4/20/20.
//  Copyright © 2020 Mohamed Abd el-latef. All rights reserved.
//

import UIKit

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
