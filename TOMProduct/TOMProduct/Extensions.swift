//
//  Extensions.swift
//  TOMProduct
//
//  Created by Anoop tomar on 1/22/17.
//  Copyright © 2017 Devtechie. All rights reserved.
//

import UIKit
extension Date {
    static func today() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}

extension NSNumber {
    func getCurrencyString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: self)!
    }
}
