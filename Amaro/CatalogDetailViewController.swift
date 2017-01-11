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
    
    @IBOutlet weak var regularPriceStackView: UIStackView!
    @IBOutlet weak var regularPrice: UILabel!
    @IBOutlet weak var actualPrice: UILabel!
    
    
    @IBOutlet weak var likeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var likeHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var likePopImageView: UIImageView!
    
    @IBOutlet weak var cartButton: UIButton!
    
    fileprivate lazy var doubleTap : UITapGestureRecognizer = {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(CatalogDetailViewController.doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        return doubleTap
    }()
    
    open lazy var model : CatalogDetailModel = {
        return CatalogDetailModel(delegate : self)
    }()
    
    var heightCollectionView : CGFloat {
        return self.collectionView.collectionViewLayout.collectionViewContentSize.height + 6
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareForPop()
        setupHeightCollectionView()
        setupProduct()
        collectionView.reloadData()
    }

    private func setup() {
        navigationItem.titleView = Help.logoTitleView
        imageProduct.addGestureRecognizer(doubleTap)
        
        guard let foto = model.product.image, model.product.image != "" else { return self.imageProduct.image = Help.imagePlaceholder}
        self.imageProduct.setImageWith(URL(string : foto)!, placeholderImage: Help.imagePlaceholder)
        
        guard let name = model.product.name else { return nameProduct.text = "" }
        nameProduct.text = name
        
        if model.product.discount_percentage != ""{
            regularPriceStackView.isHidden = false
            regularPrice.text = "de " + model.product.regular_price!
        }else {
            regularPriceStackView.isHidden = true
            regularPrice.text = ""
        }
        
        if let actual = model.product.actual_price {
            self.actualPrice.text = "por " + actual
        }
    }
    
    private func setupHeightCollectionView() {
        collectionView.constraints.forEach({(constraint) in
            if constraint.identifier == "height" {
                constraint.constant = heightCollectionView
            }
        })
    }
    func setupProduct() {
        model.getProductFromRealm()
        cartButton.isSelected = model.productIsOnChart
    }
    
    @IBAction func addProductToCart(_ sender: UIButton) {
        self.model.addProductToCart(self.model.product)
        sender.isSelected = model.productIsOnChart
        if model.productIsOnChart {
            Help.message(self, message: "Produto adicionado ao carrinho")
        }else {
            Help.message(self, message: "Produto removido do carrinho")
        }
    }
}
extension CatalogDetailViewController : CatalogDetailModelDelegate {
    func productFromCart(_ isOnCart : Bool) {
        self.cartButton.isSelected = isOnCart
    }
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
extension CatalogDetailViewController {
    func doubleTapAction() {
        self.model.addProductToCart(self.model.product)
        performPopAnimation()
    }
    
    fileprivate func performPopAnimation() {
        prepareForPop()
        likeWidthConstraint.constant = 100
        likeHeightConstraint.constant = 100
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.likePopImageView.alpha = 1
        }, completion: { (firstCompleted) -> Void in
            if(firstCompleted) {
                UIView.animate(withDuration: 0.8, animations: { () -> Void in
                    self.likePopImageView.alpha = 0
                }, completion: { (secondCompleted) -> Void in
                    
                })
            }
        })
    }
    fileprivate func prepareForPop() {
        likeWidthConstraint.constant = 0
        likeHeightConstraint.constant = 0
        likePopImageView.alpha = 0
        self.view.layoutIfNeeded()
    }
    
}
