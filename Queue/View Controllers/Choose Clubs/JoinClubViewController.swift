import UIKit

class JoinClubViewController: QueueUI.SingleTextFieldViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var clubIDTextField: QueueUI.TextField!
    @IBOutlet weak var continueBtn: QueueUI.Button!
    @IBOutlet weak var btnContainerView: UIView!
    @IBOutlet weak var btnContainerBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField = clubIDTextField
        btnBottomConstraint = btnContainerBottomConstraint
        continueBtn.setButton(title: "Find Club", state: .disabled)
    }
    
    @IBAction func editingDidChanged(_ sender: UITextField) {
        sender.text = sender.text?.replacingOccurrences(of: " ", with: "-")
        
        if let count = sender.text?.count {
            count > 0 ? continueBtn.setButton(state: .active) : continueBtn.setButton(state: .disabled)
        }
    }
    
    @IBAction func continueBtnTouched(_ sender: UIButton) {
        clubIDTextField.endEditing(true)
        
        // TODO: Implement actual logic. This is just an example
        
        let loadingVC = AlertService.loading(
            title: "Finding Club",
            message: "Hang tight for a moment while we find the club with that ID."
        )
        loadingVC.setCompletionAlert(
            title: "Could Not Find Club With That ID",
            message: "Make sure the Club ID is correct by double checking with club's admin or the club's members.",
            buttonTitle: "Okay"
        )
        
        loadingVC.present(in: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
//                loadingVC.dismiss(animated: true) {
//                    self.performSegue(withIdentifier: "toConfirmFoundClub", sender: nil)
//
//                }
                loadingVC.presentCompletion()
            }
        }
        
    }
    
}
