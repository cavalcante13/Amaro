//
//  CatalogDetailViewController.swift
//  Amaro
//
//  Created by Vollup iMac 01 on 10/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CatalogDetailViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    
    @IBOutlet weak var cartButton: UIButton!
    
    open lazy var model : CatalogDetailModel = {
        return CatalogDetailModel(delegate : self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHeightCollectionView()
        collectionView.reloadData()
    }

    private func setup() {
        guard let foto = model.product.image, model.product.image != "" else { return self.imageProduct.image = Help.imagePlaceholder}
        self.imageProduct.setImageWith(URL(string : foto)!, placeholderImage: Help.imagePlaceholder)
        
        guard let name = model.product.name else { return nameProduct.text = "" }
        nameProduct.text = name
    }
    private func setupHeightCollectionView() {
        collectionView.constraints.forEach({(constraint) in
            if constraint.identifier == "height" {
                constraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height + 6
            }
        })
    }
    @IBAction func addProductToCart(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.model.addProductToCart(self.model.product)
    }
}
extension CatalogDetailViewController : CatalogDetailModelDelegate {
    
}
extension CatalogDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width / 5) - 6, height: 56)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    }
}
extension CatalogDetailViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !model.product.sizes.isEmpty {
            
        }
    }
}
extension CatalogDetailViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.product.sizes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CatalogSizeCollectionViewCell
        cell.populate(with: self.model.product.sizes[indexPath.row])
        return cell
    }
}
