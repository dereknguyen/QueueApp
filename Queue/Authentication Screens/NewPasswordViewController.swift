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
        createAccountButton.setDisabled()
        addObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func verifyPasswordCharCount(_ sender: UITextField) {
        if let text = passwordTextField.text {
            if text.count > 5 {
                passwordRequirementLabel.textColor = Colors.textHighlightColor
                passwordRequirementLabel.text = "Valid Password"
                createAccountButton.setActive()
            }
            else {
                passwordRequirementLabel.textColor = .lightGray
                passwordRequirementLabel.text = "6 characters min."
                createAccountButton.setDisabled()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
