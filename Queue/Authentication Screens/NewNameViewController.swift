//
//  NewInputViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/23/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class NewInputViewController: QueueUI.ViewController {
    
    @IBOutlet weak var firstNameTextField: QueueUI.TextField!
    @IBOutlet weak var lastNameTextField: QueueUI.TextField!
    @IBOutlet weak var contBtn: QueueUI.Button!
    @IBOutlet weak var contBtnBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contBtn.setDisabled()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.firstNameTextField.endEditing(true)
        self.lastNameTextField.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            let adjustedHeight = keyboardFrame.height - view.safeAreaInsets.bottom

            contBtnBottomConstraint.constant = isKeyboardShowing ? adjustedHeight : 0
            
            UIView.animate(withDuration: 0, delay: 0,
              options: UIView.AnimationOptions.init(rawValue: curve), animations: {
                [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @IBAction func editingDidChanged(_ sender: UITextField) {
        guard let first = firstNameTextField.text, let last = lastNameTextField.text else { return }
        !first.isEmpty && !last.isEmpty ? contBtn.setActive() : contBtn.setDisabled()
    }
}

extension NewInputViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        firstNameTextField.layoutIfNeeded()
        lastNameTextField.layoutIfNeeded()
    }
}
