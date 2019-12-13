import UIKit

class SectionFooterCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    
    func setMessage(message: String) {
        messageLabel.isHidden = false
        messageLabel.text = message
        layoutSubviews()
    }
}
