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
    @IBOutlet weak var total: UILabel!
    
    fileprivate lazy var model : CartModel = {
        return CartModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        model.getProductsFromCart()
    }
    
    private func setup() {
        self.navigationItem.titleView = Help.logoTitleView
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        self.tableView.tableHeaderView = nil
        self.tableView.tableFooterView = nil
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
}
extension CartViewController : CartModelDelegate {
    func getProductsFromCart() {
        tableView.reloadData()
        updateTotalChart()
    }
    
    func updateTotalChart() {
        model.getTotalFromChart()
        total.text = DateFormatter.accurancyWithFraction(model.total)
    }
}
extension CartViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return model.products.isEmpty ? false : true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            model.removeProductFromChart(model.products[indexPath.row])
        default:
            break
        }
    }
}
extension CartViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CartTableViewCell
        cell.populate(with: model.products[indexPath.row])
        return cell
    }
}
