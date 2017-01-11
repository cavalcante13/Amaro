//
//  CatalogDetailModel.swift
//  Amaro
//
//  Created by Vollup iMac 01 on 10/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit
import RealmSwift

protocol CatalogDetailModelDelegate : class {
}
class CatalogDetailModel: NSObject {
    weak var delegate : CatalogDetailModelDelegate?
    
    fileprivate lazy var realm : Realm = {
        return try! Realm()
    }()
    
    var product : Product!
    
    var productIsOnChart : Bool {
        get { return product.isOnChart }
        set(newValue) { product.isOnChart = newValue }
    }
    
    var productLiked : Bool {
        get { return product.liked }
        set(newValue) { product.liked = newValue }
    }
    
    init(delegate : CatalogDetailModelDelegate) {
        self.delegate = delegate
    }

    func getProductFromRealm() {
        let products = self.realm.objects(Product.self).filter("name ==%s", self.product.name!)
        if products.count > 0 {
            self.product = products.last!
        }
    }

    func addProductToCart(_ product : Product) {
        try! self.realm.write {
            self.productIsOnChart = !productIsOnChart
            self.productLiked     = !productLiked
            self.realm.add(self.product)
        }
    }
}
