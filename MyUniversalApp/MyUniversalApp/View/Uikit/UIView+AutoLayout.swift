//
//  UIView+AutoLayout.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Activates the following constraints, provided the view has a superview:
    public func pinToSuperview() {
        guard let superview = superview else { return }
        let constraints = [
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
