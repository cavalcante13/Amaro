//
//  CartModel.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit
import RealmSwift

protocol CartModelDelegate : class {
    func getProductsFromCart()
}
class CartModel: NSObject {
    weak var delegate : CartModelDelegate?
    
    fileprivate lazy var realm : Realm = {
        return try! Realm()
    }()
    
    var products : [Product] = [Product]()
    
    init(delegate : CartModelDelegate) {
        self.delegate = delegate
    }
    
    func getProductsFromCart() {
        let products = self.realm.objects(Product.self)
        if products.count > 0 {
            products.forEach({(product) in
                self.products.append(product)
            })
            self.delegate?.getProductsFromCart()
        }
    }
}


