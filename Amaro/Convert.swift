//
//  Convert.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class Convert: NSObject {
    
    
    static func convertToProduct(_ result : NSDictionary)-> Product {
        let product = Product()
        
        if let name = result["name"] as? String {
            product.name = name
        }
        if let style = result["style"] as? String {
            product.style = style
        }
        if let code_color = result["code_color"] as? String {
            product.code_color = code_color
        }
        if let color_slug = result["color_slug"] as? String {
            product.color_slug = color_slug
        }
        if let color = result["color"] as? String {
            product.color = color
        }
        if let regular_price = result["regular_price"] as? String {
            product.regular_price = regular_price
        }
        if let actual_price = result["actual_price"] as? String {
            product.actual_price = actual_price
        }
        if let discount_percentage = result["discount_percentage"] as? String {
            product.discount_percentage = discount_percentage
        }
        if let image = result["image"] as? String {
            product.image = image
        }
        if let on_sale = result["on_sale"] as? Bool {
            product.on_sale = on_sale
        }
        if let sizes = result["sizes"] as? NSArray {
            for size in sizes {
                product.sizes.append(convertToSize(size as! NSDictionary))
            }
        }
        return product
    }
    
    static func convertToSize(_ result : NSDictionary)-> Size {
        let size = Size()
        if let available = result["available"] as? Bool {
            size.available = available
        }
        if let sizeStr = result["size"] as? String {
            size.size = sizeStr
        }
        if let sku = result["sku"] as? String {
            size.sku = sku
        }
        return size
    }
}

