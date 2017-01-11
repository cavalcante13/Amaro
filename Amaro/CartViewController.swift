//
//  CartViewController.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    
    
    fileprivate lazy var model : CartModel = {
        return CartModel(delegate: self)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getProductsFromCart()
    }
}
extension CartViewController : CartModelDelegate {
    func getProductsFromCart() {
        tableView.reloadData()
    }
}
extension CartViewController : UITableViewDelegate {
    
}
extension CartViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
}
