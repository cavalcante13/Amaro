//
//  Help.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class Help: NSObject {
    static let imagePlaceholder = UIImage(named: "placeholder")
    static let messageError = "Could not complete the request, please, try again"

    static var logoTitleView : UIImageView = {
        let logoTitleView = UIImageView(frame: CGRect(x: 0, y: 0,width: 92,height: 44))
        logoTitleView.image = UIImage(named: "NavBar")
        logoTitleView.contentMode = UIViewContentMode.scaleAspectFit
        return logoTitleView
    }()
}
