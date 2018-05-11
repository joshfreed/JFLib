//
//  UISearchBar+setSearchFieldColor.swift
//  JFLib
//
//  Created by Josh Freed on 5/11/18.
//  Copyright © 2018 Josh Freed. All rights reserved.
//

import UIKit

extension UISearchBar {
    public func setSearchFieldColor(_ color: UIColor) {
        if
            let textfield = self.value(forKey: "searchField") as? UITextField,
            let backgroundview = textfield.subviews.first
        {
            backgroundview.backgroundColor = color
            backgroundview.layer.cornerRadius = 10
            backgroundview.clipsToBounds = true
        }
    }
}
