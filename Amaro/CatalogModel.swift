//
//  CatalogModel.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

protocol CatalogModelDelegate : class {
    func model(jsonResponse model : CatalogModel, error : NSError?)
}
class CatalogModel: NSObject {
    weak var delegate : CatalogModelDelegate?
    
    open lazy var products : [Product] = {
        return [Product]()
    }()
    
    init(delegate : CatalogModelDelegate) {
        self.delegate = delegate
    }
    
    func searchProduct(with query : String) {
        if !products.isEmpty {
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
            let result = (products as NSArray).filtered(using: predicate) as! [Product]
            self.products.removeAll()
            self.products = result
            self.delegate?.model(jsonResponse: self, error: nil)
        }
    }
    func getJson() {
        CatalogService.getJson(resource: "products") { (result) -> (Void) in
            if let result = result as? NSDictionary {
                if let products = result["products"] as? NSArray {
//                    products.forEach({})
                    for product in products {
                        self.products.append(Convert.convertToProduct(product as! NSDictionary))
                    }
                    self.delegate?.model(jsonResponse: self, error: nil)
                }else {
                    self.delegate?.model(jsonResponse: self, error: NSError(domain: Help.messageError, code: 0, userInfo: nil))
                }
            }else {
                self.delegate?.model(jsonResponse: self, error: NSError(domain: Help.messageError, code: 0, userInfo: nil))
            }
        }
    }
    
}
