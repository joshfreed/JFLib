//
//  UIViewController+showAlert.swift
//  JFLib
//
//  Created by Josh Freed on 8/31/17.
//  Copyright © 2017 Josh Freed. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String, message: String, handler: ((UIAlertAction) -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    public func showAlert(error: Error, title: String? = nil, handler: ((UIAlertAction) -> ())? = nil) {
        let title = title ?? "Error"
        showAlert(title: title, message: "\(error.localizedDescription)", handler: handler)
    }
}

