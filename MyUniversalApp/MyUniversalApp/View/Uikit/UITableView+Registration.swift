//
//  UITableView+Registration.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func register<T: UITableViewCell>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    /// Before using this, you need to ensure that the cell is registered using register<T: UITableViewCell>()
    public func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
}

