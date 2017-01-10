//
//  CatalogService.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CatalogService: NSObject {
    
    static func getJson(resource : String, completion : (Any?) -> (Void)) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath : path), options: .mappedIfSafe) {
                if let result = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    completion(result as! NSDictionary)
                }
            }
        }
    }
    
}
