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
        let products = self.realm.objects(Product.self).filter("isOnChart ==%s", 1).sorted(byProperty: "name", ascending: true)
        if products.count > 0 {
            products.forEach({(product) in
                self.products.append(product)
            })
            self.delegate?.getProductsFromCart()
        }
    }
    
    func getTotalFromChart() {
        
    }
    
    func removeProductFromChart(_ product : Product) {
        try! realm.write {
            product.isOnChart = false
            self.realm.add(product)
        }
        self.products.removeAll()
        self.getProductsFromCart()
        self.delegate?.getProductsFromCart()
    }
}


