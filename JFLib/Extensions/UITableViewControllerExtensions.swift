//
//  UITableViewController.swift
//  JFLib
//
//  Created by Josh Freed on 3/7/18.
//  Copyright © 2018 Josh Freed. All rights reserved.
//

import UIKit

extension UITableViewController {
    public func showEmptyMessage(_ message: String) {
        let container = UIView()
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 21)
        messageLabel.sizeToFit()
        
        container.addSubview(messageLabel)
        messageLabel.jpfPinToSuperview(padding: 32)
        
        tableView.backgroundView = container
    }
    
    public func hideEmptyMessage() {
        tableView.backgroundView = nil
    }
    
    public func showEmptyMessageInHeader(_ message: String) {
        let messageLabel = UILabel()
        messageLabel.text = "\n \(message)"
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 21)
        messageLabel.sizeToFit()
        tableView.tableHeaderView = messageLabel
    }
    
    public func hideEmptyMessageFromHeader() {
        tableView.tableHeaderView = nil
    }
}
