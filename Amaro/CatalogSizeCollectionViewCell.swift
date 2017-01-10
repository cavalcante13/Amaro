//
//  CatalogSizeCollectionViewCell.swift
//  Amaro
//
//  Created by Vollup iMac 01 on 10/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CatalogSizeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageSize: UIImageView!
    
    func populate(with size : Size) {
        imageSize.image = UIImage(named: "size_\(size.size!.lowercased())")
    }
}
