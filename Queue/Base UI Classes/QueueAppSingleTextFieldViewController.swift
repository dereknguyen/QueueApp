import UIKit

class QueueAppSingleTextFieldViewController: QueueUI.ViewController {

    /// TextField that will receive user input. **Must be initialize before view appear.**
    weak var textField: QueueUI.TextField!
    
    /// The bottom constraint of the continue button in view. **Must be initialized before view appear.**
    weak var btnBottomConstraint: NSLayoutConstraint!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkInitialize()
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toggleTextFieldFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func handleKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            let adjustedHeight = keyboardFrame.height - view.safeAreaInsets.bottom

            btnBottomConstraint.constant = isKeyboardShowing ? adjustedHeight : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.init(rawValue: curve), animations: {
                [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func toggleTextFieldFirstResponder() {
        if let count = textField.text?.count, count < 1 {
            textField.becomeFirstResponder()
        }
    }
    
    private func checkInitialize() {
        if (textField == nil) || (btnBottomConstraint == nil) {
            fatalError("TextField and Continue Button Bottom Constraint are not set")
        }
    }
}
