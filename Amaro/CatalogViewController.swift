//
//  CatalogViewController.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {

    fileprivate lazy var model : CatalogModel = {
        return CatalogModel(delegate : self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension CatalogViewController : CatalogModelDelegate {
    
}
