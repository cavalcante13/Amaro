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
        guard let foto = product.image, product.image != "" else { return self.imageProduct.image = Help.imagePlaceholder}
        self.imageProduct.setImageWith(URL(string : foto)!, placeholderImage: Help.imagePlaceholder)
        
        guard let name = product.name else {return nameProduct.text = ""}
        nameProduct.text = name
    }
}
