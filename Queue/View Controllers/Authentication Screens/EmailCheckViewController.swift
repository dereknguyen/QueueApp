//
//  EmailCheckViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/22/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class EmailCheckViewController: QueueUI.SingleTextFieldViewController {

    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: QueueUI.TextField!
    @IBOutlet weak var continueButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var continueButton: QueueUI.Button!
    @IBOutlet weak var domainSuggestionStk: UIStackView!
    
    @IBOutlet var domainSuggestionBtns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupUI() {
        domainSuggestionStk.isHidden = true
        continueButton.setButton(style: .disabled)
        
        textField = emailAddressTextField
        btnBottomConstraint = continueButtonBottomConstraint
    }
    
    @IBAction func emailTextFieldDidChanged(_ sender: UITextField) {
        guard let email = emailAddressTextField.text else { return }
        
        // Check if email is valid, activate continue button.
        email.isValidEmail() ? continueButton.setButton(style: .active) : continueButton.setButton(style: .disabled)
    
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
                continueButton.setButton(style: .active)
            }
        }
    }
    
    @IBAction func continueTouched(_ sender: UIButton) {
        // Loading Screen View Controller
        let loadingVC = AlertServiceController.makeAlertController()
        loadingVC.setText(title: LoadingMessage.email.title, message: LoadingMessage.email.msg)
        
        if let email = emailAddressTextField.text {
            
            loadingVC.present(as: .Loading, in: self) {
                [weak self] in
                guard let this = self else { fatalError() }
                
                // Check if account exist
                if this.userAccountExist(email: email) {
                    loadingVC.dismiss(animated: true) {
                        DispatchQueue.main.async {
                            this.performSegue(withIdentifier: "emailCheckToLogin", sender: nil)
                        }
                    }
                }
                else {
                    loadingVC.dismiss(animated: true) {
                        DispatchQueue.main.async {
                            // Direct user to new account flow
                            this.performSegue(withIdentifier: "emailCheckToNoAccount", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
    private func userAccountExist(email: String) -> Bool {
        // TODO: Handle checking account exist or not
        return false
    }
}

