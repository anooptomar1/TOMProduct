//
//  Product.swift
//  TOMProduct
//
//  Created by Anoop tomar on 1/22/17.
//  Copyright © 2017 Devtechie. All rights reserved.
//

import Foundation
class Product: NSObject {
    var name: String?
    var image: String?
    var price: NSNumber?
    var desc: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            self.desc = value as? String
        } else {
            super.setValue(value, forKey: key)
        }
        
    }
}
