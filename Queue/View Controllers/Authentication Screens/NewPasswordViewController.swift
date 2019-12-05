//
//  NewPasswordViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/25/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class NewPasswordViewController: QueueUI.ViewController {
    
    @IBOutlet weak var passwordTextField: QueueUI.TextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var createAccountButton: QueueUI.Button!
    @IBOutlet weak var passwordRequirementLabel: UILabel!
    @IBOutlet weak var createAccountButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountButton.setButton(state: .disabled)
        addObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func verifyPasswordCharCount(_ sender: UITextField) {
        if let text = passwordTextField.text {
            if text.count > 5 {
                passwordRequirementLabel.textColor = .QueueAppViolet
                passwordRequirementLabel.text = "Valid Password"
                createAccountButton.setButton(state: .active)
            }
            else {
                passwordRequirementLabel.textColor = .lightGray
                passwordRequirementLabel.text = "6 characters min."
                createAccountButton.setButton(state: .disabled)
            }
        }
    }
    
    @IBAction func createAccountButtonTouched(_ sender: UIButton) {
        
    }
    
    @IBAction func showPasswordButtonTouched(_ sender: UIButton) {
        
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            let adjustedHeight = keyboardFrame.height - view.safeAreaInsets.bottom

            createAccountButtonBottomConstraint.constant = isKeyboardShowing ? adjustedHeight : 0
            
            UIView.animate(withDuration: 0, delay: 0,
              options: UIView.AnimationOptions.init(rawValue: curve), animations: {
                [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
