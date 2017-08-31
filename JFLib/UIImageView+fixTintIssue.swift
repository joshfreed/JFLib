//
//  UIImageView.swift
//  JFLib
//
//  Created by Josh Freed on 1/7/17.
//  Copyright © 2017 Josh Freed. All rights reserved.
//

import UIKit

extension UIImageView {
    public func fixTintIssue() {
        let temp = image
        image = nil
        image = temp
    }
}

