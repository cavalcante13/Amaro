//
//  CartTableViewCell.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 11/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var imageProduct : UIImageView!
    @IBOutlet weak var nameProduct  : UILabel!
    @IBOutlet weak var color        : UILabel!
    @IBOutlet weak var installments : UILabel!
    @IBOutlet weak var actualPrice  : UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
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
        if let color = product.color {
            self.color.text = color
        }
        if let installments = product.installments {
            self.installments.text = installments
        }
        if let actualPrice = product.actual_price {
            self.actualPrice.text = actualPrice
        }

        print(product)
    }
}
