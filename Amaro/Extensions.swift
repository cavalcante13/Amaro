//
//  Extensions.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

public enum UITableViewStatus : Int {
    case loading
    case loaded
    case empty
    case error
}
var tableStatus : UITableViewStatus = UITableViewStatus(rawValue: 0)!
extension UITableView {
    var status : UITableViewStatus {
        get { return tableStatus }
        set(newValue) { tableStatus = newValue }
    }
    
    func register<T: UITableViewCell>(class: T.Type) where T:ReusableView {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T:UITableViewCell>(forIndexPath indexPath: IndexPath)-> T where T:ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
            else { fatalError("Could not dequeue cell with identifier:\(T.reuseIdentifier)")}
        return cell
    }
}
extension UICollectionView {
    func register<T: UICollectionViewCell>(class: T.Type) where T:ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T:UICollectionViewCell>(forIndexPath indexPath: IndexPath)-> T where T:ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
            else { fatalError("Could not dequeue cell with identifier:\(T.reuseIdentifier)")}
        return cell
    }
}
protocol ReusableView: class {}
extension ReusableView where Self : UIView {
    static var reuseIdentifier : String {
        return String(describing: self)
    }
}
extension UITableViewCell       : ReusableView{}
extension UICollectionViewCell  : ReusableView{}
