//
//  UITableView.swift
//  JFLib
//
//  Created by Josh Freed on 3/21/18.
//  Copyright © 2018 Josh Freed. All rights reserved.
//

import UIKit

extension UITableView {
    public func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        self.layoutTableHeaderFooterView(header)
        self.tableHeaderView = header
    }
    
    public func setAndLayoutTableFooterView(footer: UIView) {
        self.tableFooterView = footer
        self.layoutTableHeaderFooterView(footer)
        self.tableFooterView = footer
    }
    
    private func layoutTableHeaderFooterView(_ view: UIView) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        let height = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = view.frame
        frame.size.height = height
        view.frame = frame
    }
}
