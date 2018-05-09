//
//  JPFFancyTextField.swift
//  JFLib
//
//  Created by Josh Freed on 3/22/18.
//  Copyright © 2018 Josh Freed. All rights reserved.
//

import UIKit

@objc public protocol JPFFancyTextFieldDelegate: class {
    @objc optional func textFieldShouldReturn(_ textField: JPFFancyTextField) -> Bool
}

public class JPFFancyTextField: NibDesignable {
    @IBOutlet weak var floatingLabel: UILabel!
    @IBOutlet weak var _theTextField: TheTextField!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var labelHiddenConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelShownConstraint: NSLayoutConstraint!

    public var delegate: JPFFancyTextFieldDelegate?
    public var textField: UITextField {
        return _theTextField
    }
    
    @IBInspectable
    public var placeholder: String? {
        didSet {
            floatingLabel.text = placeholder
            _theTextField.placeholder = placeholder
        }
    }
    
    public var text: String? {
        return _theTextField.text
    }
    
    public override var canBecomeFirstResponder: Bool {
        return _theTextField.canBecomeFirstResponder
    }
    
    @IBInspectable
    public var secureTextEntry: Bool = false {
        didSet {
            _theTextField.isSecureTextEntry = secureTextEntry
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    public override func prepareForInterfaceBuilder() {
        configure()
    }
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        return _theTextField.becomeFirstResponder()
    }
    
    @discardableResult
    public override func resignFirstResponder() -> Bool {
        return _theTextField.resignFirstResponder()
    }
    
    func configure() {
        _theTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        _theTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        _theTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        _theTextField.delegate = self
        
        configureFloatingLabel()
        configureDetailLabel()
    }
    
    // MARK: - Floating Label
    
    private func configureFloatingLabel() {
        floatingLabel.textColor = _theTextField.placeholderColor
        floatingLabel.text = placeholder
        
        floatingLabel.alpha = 0
        labelHiddenConstraint.isActive = true
        labelShownConstraint.isActive = false
        updateFloatingLabel()
    }
    
    func updateFloatingLabel() {
        if let text = _theTextField.text, !text.isEmpty {
            labelHiddenConstraint.isActive = false
            labelShownConstraint.isActive = true
            
            UIView.animate(withDuration: 0.25) {
                self.floatingLabel.alpha = 1
                self.layoutIfNeeded()
            }
        } else {
            labelShownConstraint.isActive = false
            labelHiddenConstraint.isActive = true
            
            UIView.animate(withDuration: 0.25) {
                self.floatingLabel.alpha = 0
                self.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Detail Message
    
    private func configureDetailLabel() {
        hideDetailMessage()
    }
    
    public func showDetailMessage(_ message: String) {
        detailLabel.text = message
        detailLabel.isHidden = false
    }
    
    public func hideDetailMessage() {
        detailLabel.isHidden = true
        detailLabel.text = nil
    }

    // MARK: - Text field events
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateFloatingLabel()
    }
    
    @objc func textFieldDidBeginEditing() {
        _theTextField.showActiveBorder()
    }
    
    @objc func textFieldDidEndEditing() {
        _theTextField.showInactiveBorder()
    }
    
    // MARK: - Validation States
    
    public func displayInvalid() {
        _theTextField.showErrorBorder()
        hideDetailMessage()
    }
    
    public func displayInvalid(message: String) {
        _theTextField.showErrorBorder()
        showDetailMessage(message)
    }
    
    public func displayValid() {
        _theTextField.showInactiveBorder()
        hideDetailMessage()
    }
}

extension JPFFancyTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn?(self) ?? false
    }
}

class TheTextField: UITextField {
    private var inactiveBorder: UIView?
    private var activeBorder: UIView?
    private var errorBorder: UIView?
    
    fileprivate var placeholderColor: UIColor = UIColor.gray.withAlphaComponent(0.7)
    
    init() {
        super.init(frame: CGRect.zero)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        borderStyle = .none
        
        inactiveBorder = addBorder(edges: .bottom, color: placeholderColor, thickness: 1).first
        activeBorder = addBorder(edges: .bottom, color: .black, thickness: 1).first
        errorBorder = addBorder(edges: .bottom, color: .red, thickness: 1).first
        
        showInactiveBorder()
    }

    // Border Helpers
    
    func showErrorBorder() {
        errorBorder?.isHidden = false
        activeBorder?.isHidden = true
        inactiveBorder?.isHidden = true
    }
    
    func showActiveBorder() {
        activeBorder?.isHidden = false
        inactiveBorder?.isHidden = true
        errorBorder?.isHidden = true
    }
    
    func showInactiveBorder() {
        errorBorder?.isHidden = true
        activeBorder?.isHidden = true
        inactiveBorder?.isHidden = false
    }
}
