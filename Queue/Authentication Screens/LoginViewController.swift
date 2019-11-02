//
//  LoginViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/22/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: QueueUI.ViewController {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var passwordTextField: QueueUI.TextField!
    @IBOutlet weak var passwordStk: UIStackView!
    @IBOutlet weak var loginBtn: QueueUI.Button!
    @IBOutlet weak var loginBtnContentView: UIView!
    @IBOutlet weak var hidePasswordButton: UIButton!
    @IBOutlet weak var loginBtnBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.setDisabled()
        addObserverAndTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        passwordTextField.endEditing(true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
        
    private func addObserverAndTarget() {
        let endEditGesture = UITapGestureRecognizer(target: self.contentScrollView,
                                                    action: #selector(UIView.endEditing))
        
        contentScrollView.addGestureRecognizer(endEditGesture)
        passwordTextField.addTarget(self, action: #selector(isValidPassword), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Current solution to verifying a valid password.
    // Password Req: 6 Characters minimum
    @objc func isValidPassword() {
        guard let count = passwordTextField.text?.count else { return }
        count > 5 ? loginBtn.setActive() : loginBtn.setDisabled()
    }
    
    // Handle UI contents to avoid keyboard when keyboard show or hide.
    @objc func handleKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let isKeyboardVisible = notification.name == UIResponder.keyboardWillShowNotification
            let adjustedHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            
            loginBtnBottomConstraint.constant = isKeyboardVisible ? adjustedHeight : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.init(rawValue: curve), animations: {
                [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        // Get the password frame in its superview context
        let passwordFrame = passwordStk.superview!.convert(passwordStk.frame, to: nil)
        
        // Calculate offset needed to make sure non-overlapping UI element.
        // In this case: login button represent the top of keyboard and can overlap with textfield.
        let offset = offsetForConflictFrames(topFrame: passwordFrame, bottomFrame: loginBtnContentView.frame)
        
        // Scroll scrollview up to the offset value so that UI element does not overlap with keyboard.
        contentScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: offset, right: 0)
        contentScrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
    }
    
    // Calculate offset needed to clear view overlapping conflict.
    private func offsetForConflictFrames(topFrame: CGRect, bottomFrame: CGRect) -> CGFloat {
        let conflict = (topFrame.origin.y + topFrame.height) - bottomFrame.origin.y
        return conflict > 0 ? conflict + 20 : 0
    }
    
    // Handling hiding or showing password using "Secure Text Entry"
    @IBAction func hidePasswordBtnTouched(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        if passwordTextField.isSecureTextEntry {
            hidePasswordButton.setTitle("Show Password", for: .normal)
        }
        else {
            hidePasswordButton.setTitle("Hide Password", for: .normal)
        }
    }
    
    @IBAction func loginTouched(_ sender: UIButton) {
        
    }
    
}
