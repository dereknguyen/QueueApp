//
//  EmailCheckViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/22/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class EmailCheckViewController: QueueUI.ViewController {

    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: QueueUI.TextField!
    @IBOutlet var domainSuggestionBtns: [UIButton]!
    @IBOutlet weak var contBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contBtn: QueueUI.Button!
    @IBOutlet weak var domainSuggestionStk: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
        addObserverAndTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let text = emailAddressTextField.text, text.isEmpty {
            emailAddressTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resignFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        titleLabel.text = Copy.EmailCheckView.title.rawValue
        messageLabel.text = Copy.EmailCheckView.message.rawValue
        domainSuggestionStk.isHidden = true
        contBtn.setDisabled()
    }
    
    private func addObserverAndTarget() {
        emailAddressTextField.addTarget(self, action: #selector(handleEmailInput), for: .editingChanged)
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

            contBtnBottomConstraint.constant = isKeyboardShowing ? adjustedHeight : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.init(rawValue: curve), animations: {
                [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
        
    // Handling user editing email textfield
    @objc private func handleEmailInput() {
        guard let email = emailAddressTextField.text else { return }
        
        // Check if email is valid, activate continue button.
        email.isValidEmail() ? contBtn.setActive() : contBtn.setDisabled()
    
        // Start string range of interest after first occurance of "@" symbol
        if let range = email.range(of: "@") {
            
            // Our email prefix will be the characters after the "@" symbol
            let emailPrefix = email[range.upperBound...].lowercased()
            
            // If user hasn't type anything after initial "@", suggest comment domains.
            // Else, we will filter the domain list for prefix matches.
            let emailDomains = emailPrefix.count > 0  ?
                domains.filter { $0.hasPrefix(emailPrefix) } + emptyDomains : commonDomains
            
            // Our work around for the case of less than 4 matches is that we will
            //  append on 4 empty strings. We will relies on zip() to truncate
            //  domain list to 4 entries.
            
            // Create a sequence pair between our filtered domains and suggested domain button.
            // Then set button title for its matching pair of suggested domain.
            //
            // Zip will truncate input arrays to the shorter of the input arrays.
            // This benefit our work arround mentioned above.
            zip(emailDomains, domainSuggestionBtns).forEach { $1.setTitle($0, for: .normal) }

            // If we has an exact match, hide suggestions
            domainSuggestionStk.isHidden = emailDomains.contains(emailPrefix)
        }
        else {
            // If user has not type "@", hide suggestion
            domainSuggestionStk.isHidden = true
        }
    }
    
    @IBAction func suggestedDomainTouched(_ sender: UIButton) {
        if let domain = sender.title(for: .normal), !domain.isEmpty,
            let email = emailAddressTextField.text,
            let username = email.components(separatedBy: "@").first {
            
            domainSuggestionStk.isHidden = true
            emailAddressTextField.text = username + "@" + domain
            
            if let email = emailAddressTextField.text, email.isValidEmail() {
                contBtn.setActive()
            }
        }
    }
    
    @IBAction func continueTouched(_ sender: UIButton) {
        emailAddressTextField.resignFirstResponder()
        
        let loadingVC = AlertService.loadingController(title: Copy.EmailLoadingView.title.rawValue,
                                                       message: Copy.EmailLoadingView.message.rawValue)
        present(loadingVC, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                loadingVC.dismiss(animated: true) {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "emailCheckToLogin", sender: nil)
                    }
                }
            })
        })
    }
    
}

