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
        setupUI()
        addObserverAndTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordTextField.becomeFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        titleLabel.text = Copy.LoginView.title.rawValue
        messageLabel.text = Copy.LoginView.message.rawValue
        loginBtn.setDisabled()
    }
    
    private func addObserverAndTarget() {
        contentScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self.contentScrollView,
                                                                      action: #selector(UIView.endEditing(_:))))
        passwordTextField.addTarget(self, action: #selector(isValidPassword), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func isValidPassword() {
        guard let count = passwordTextField.text?.count else { return }
        count > 5 ? loginBtn.setActive() : loginBtn.setDisabled()
    }
    
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
        
        let passwordFrame = passwordStk.superview!.convert(passwordStk.frame, to: nil)
        let heightConflict = viewConflictOffset(topFrame: passwordFrame, bottomFrame: loginBtnContentView.frame)
        
        contentScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: heightConflict, right: 0)
        contentScrollView.setContentOffset(CGPoint(x: 0, y: heightConflict), animated: true)

    }
    
    private func viewConflictOffset(topFrame: CGRect, bottomFrame: CGRect) -> CGFloat {
        let conflict = (topFrame.origin.y + topFrame.height) - bottomFrame.origin.y
        return conflict > 0 ? conflict + 20 : 0
    }
    
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
