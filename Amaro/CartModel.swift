//
//  CartModel.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

protocol CartModelDelegate : class {
    func getProductsFromCart()
}
class CartModel: NSObject {
    weak var delegate : CartModelDelegate?
    
    var products : [Product] = [Product]()
    
    init(delegate : CartModelDelegate) {
        self.delegate = delegate
    }
    
    func getProductsFromCart() {
        
    }
}


