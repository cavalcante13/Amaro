//
//  CatalogViewController.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    
    fileprivate lazy var model : CatalogModel = {
        return CatalogModel(delegate : self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        model.getJson()
        
    }
    private func setup() {
        self.navigationItem.titleView = Help.logoTitleView
    }
}
extension CatalogViewController : CatalogModelDelegate {
    func model(jsonResponse model : CatalogModel, error : NSError?) {
        if error == nil {
            
        }else {
            
        }
        collectionView.reloadData()
    }
}
extension CatalogViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width / 2) - 6, height: 286)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    }
}
extension CatalogViewController : UICollectionViewDelegate {
    
}
extension CatalogViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CatalogCollectionViewCell
        cell.populate(with: model.products[indexPath.row])
        return cell
    }
}
