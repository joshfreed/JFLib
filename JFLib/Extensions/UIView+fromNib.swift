//
//  UIView+fromNib.swift
//  JFLib
//
//  Created by Josh Freed on 5/9/18.
//  Copyright © 2018 Josh Freed. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    public func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        contentView.jpfPinToSuperview()
        return contentView
    }
}
