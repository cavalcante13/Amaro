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
    
    var product : Product!
    
    init(delegate : CatalogDetailModelDelegate) {
        self.delegate = delegate
    }
    
    func addProductToCart(_ product : Product) {
        
    }
}
