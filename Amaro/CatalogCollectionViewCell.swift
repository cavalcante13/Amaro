//
//  CatalogCollectionViewCell.swift
//  Amaro
//
//  Created by Vollup iMac 01 on 10/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit
import AFNetworking

class CatalogCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discount: UILabel!
    
    @IBOutlet weak var regularPriceStackView: UIStackView!
    @IBOutlet weak var regularPrice: UILabel!
    @IBOutlet weak var actualPriceStackView: UIStackView!
    @IBOutlet weak var actualPrice: UILabel!
    
    @IBOutlet weak var sizes: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        self.imageProduct.contentMode = .scaleToFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
        self.layer.borderWidth  = 1
        self.layer.borderColor  = UIColor.lightText.cgColor
    }
    
    func populate(with product : Product) {
        if let foto = product.image, product.image != "" {
            self.imageProduct.setImageWith(URL(string : foto)!, placeholderImage: Help.imagePlaceholder)
        }else {
            self.imageProduct.image = Help.imagePlaceholder
        }
        
        if let name = product.name {
            nameProduct.text = name
        }
        
        if product.discount_percentage != ""{
            discountView.isHidden = false
            discount.text = product.discount_percentage
            
            regularPriceStackView.isHidden = false
            regularPrice.text = "de " + product.regular_price!
        }else {
            discountView.isHidden = true
            regularPriceStackView.isHidden = true
            regularPrice.text = ""
        }
        
        if let actual = product.actual_price {
            self.actualPrice.text = "por " + actual
        }
        
        if let sizeStr = product.sizeStr {
            self.sizes.text = sizeStr
        }
    }
}
