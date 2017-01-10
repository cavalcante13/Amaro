//
//  Extensions.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

public enum UITableViewState : Int {
    case loading
    case loaded
    case empty
    case error
}
var tableState : UITableViewState = UITableViewState(rawValue: 0)!
extension UITableView {
    var status : UITableViewStatus {
        get {
            return tableState
        }
        set(newValue) {
            tableState = newValue
        }
    }
    
    func register<T: UITableViewCell>(class: T.Type) where T:ReusableView {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T:UITableViewCell>(forIndexPath indexPath: IndexPath)-> T where T:ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
            else { fatalError("Could not dequeue cell with identifier:\(T.reuseIdentifier)")}
        return cell
    }
    
    func dequeueErrorReusableCell<T:UITableViewCell>(closure : @escaping ((Void)-> (Void)))-> T where T:ReusableView {
        let t = T.dequeueErrorReusableCell
        t.tryAgainAction = { closure() }
        return t as! T
    }
    func dequeueEmptyReusableCell<T:UITableViewCell>()-> T where T:ReusableView {
        return T.dequeueEmptyReusableCell as! T
    }
}
protocol ReusableView: class {}
extension ReusableView where Self : UIView {
    static var reuseIdentifier : String {
        return String(describing: self)
    }
//    static var dequeueErrorReusableCell : ErrorTableViewCell {
//        return ErrorTableViewCell(style: .default, reuseIdentifier: UITableViewCell.reuseIdentifier)
//    }
//    static var dequeueEmptyReusableCell : EmptyTableViewCell {
//        return EmptyTableViewCell(style: .default, reuseIdentifier: UITableViewCell.reuseIdentifier)
//    }
}
extension UITableViewCell : ReusableView{}
