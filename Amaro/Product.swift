//
//  Product.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit
import RealmSwift

class Product: Object {
    dynamic var name            : String?
    dynamic var style           : String?
    dynamic var code_color      : String?
    dynamic var color_slug      : String?
    dynamic var color           : String?
    dynamic var regular_price   : String?
    dynamic var actual_price    : String?
    dynamic var discount_percentage : String?
    dynamic var installments    : String?
    dynamic var image           : String?
    dynamic var on_sale         = false
    dynamic var sizes           = [Size]()
    
    override static func ignoredProperties() -> [String] {
        return ["sizes"]
    }
}
class Size : Object {
    dynamic var available = false
    dynamic var size      : String?
    dynamic var sku       : String?
}

