//
//  TextField.swift
//  TextFieldPlay
//
//  Created by Derek Nguyen on 10/9/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit



class CustomTextField: UITextField {
    
    public var placeholderColor: UIColor = .lightGray
    public var placeholderErrorColor: UIColor = .red
    
    /// UILabel for placeholder
    private let placeholderLabel = UILabel()
        
    private var isActive: Bool {
        guard let text = text else { return false }
        return !text.isEmpty || isEditing
    }
        
    override open func drawPlaceholder(in rect: CGRect) { }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: 0.0, dy: 0.0 + placeholderLabel.font.lineHeight / 2)
    }
            
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(animatePlaceholder),
                                                   name: UITextField.textDidEndEditingNotification,
                                                   object: self)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(animatePlaceholder),
                                                   name: UITextField.textDidBeginEditingNotification,
                                                   object: self)
        }
        else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    private func updatePlaceholder() {
        placeholderLabel.text = placeholder?.uppercased()
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.layer.anchorPoint = CGPoint.zero
        
        placeholderLabel.textColor = placeholderColor
        
        if isActive {
            placeholderLabel.font = UIFont.systemFont(ofSize: self.font?.pointSize ?? 13.0, weight: .heavy)
            placeholderLabel.transform = CGAffineTransform(scaleX: 0.60, y: 0.60)
                .translatedBy(x: 0.0, y: -placeholderLabel.font.lineHeight)
            placeholderLabel.alpha = 0.7
        }
        else {
            placeholderLabel.font = UIFont.systemFont(ofSize: self.font?.pointSize ?? 13.0, weight: .heavy)
            placeholderLabel.transform = .identity
            placeholderLabel.frame = placeholderRect(forBounds: bounds)
            placeholderLabel.alpha = 0.3
        }
    }
    
    @objc private func animatePlaceholder() {
        UIView.animate(withDuration: 0.15) {
            [weak self] in
            
            guard let this = self else { return }
            this.updatePlaceholder()
        }
    }
    
    public func setErrorMessage(message: String) {
        // TODO: To be implemented
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard isFirstResponder == false else { return }
        
        updatePlaceholder()
        addSubview(placeholderLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        guard isFirstResponder == false else { return }
        
        updatePlaceholder()
        addSubview(placeholderLabel)
    }
}


