//
//  CartTableViewCell.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 11/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var installments: UILabel!
    @IBOutlet weak var actualPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func populate(with product : Product) {
        guard let foto = product.image, product.image != "" else { return self.imageProduct.image = Help.imagePlaceholder}
        self.imageProduct.setImageWith(URL(string : foto)!, placeholderImage: Help.imagePlaceholder)
        
        guard let name = product.name else { return nameProduct.text = "" }
        nameProduct.text = name
    }
}
