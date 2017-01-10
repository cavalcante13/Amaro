//
//  CatalogViewController.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    
    
    fileprivate lazy var model : CatalogModel = {
        return CatalogModel(delegate : self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getJson()
    }
}
extension CatalogViewController : CatalogModelDelegate {
    func model(jsonResponse model : CatalogModel, error : NSError?) {
        if error == nil {
            
        }else {
            
        }
    }
}
extension CatalogViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
extension CatalogViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CatalogTableViewCell
        return cell
    }
}
