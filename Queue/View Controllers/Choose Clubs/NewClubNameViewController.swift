import UIKit

class NewClubNameViewController: QueueUI.SingleTextFieldViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var continueBtn: QueueUI.Button!
    @IBOutlet weak var btnContainerView: UIView!
    @IBOutlet weak var btnContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var clubNameTextField: QueueUI.TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.setButton(title: "Check Name Availability", state: .disabled)
        textField = clubNameTextField
        btnBottomConstraint = btnContainerBottomConstraint
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        if let count = clubNameTextField.text?.count {
            count > 0 ? continueBtn.setButton(state: .active) : continueBtn.setButton(state: .disabled)
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        clubNameTextField.endEditing(true)
        _ = clubNameTextField.text?.replacingOccurrences(of: " ", with: "-")
        
        let loadingVC = AlertService.loading(
            title: "Verifying Club Name",
            message: "Hang tight for a moment while we verify that it is a unique name."
        )
        loadingVC.present(in: self)
        
        // TODO: CHECK WITH SERVER IF EXIST
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                loadingVC.dismiss(animated: true) {
                    self.performSegue(withIdentifier: "toClubImage", sender: nil)
                }
            }
        }
    }
}
