import UIKit

class BasicSettingCell: UITableViewCell {
    
    enum ButtonStyle {
        case destructive
        case normal
    }
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    func configure(
        title: String?,
        leftImage: UIImage? = nil,
        rightImage: UIImage? = nil,
        style: CourtSettingCell.ButtonStyle = .normal
    ) {
        
        titleLabel.text = title
        
        if let image = leftImage {
            leftImageView.image = image
        }
        else {
            leftImageView.isHidden = true
        }
        
        if let image = rightImage {
            rightImageView.image = image
        }
        else {
            rightImageView.isHidden = true
        }
        
        switch style {
        case .destructive:
            backgroundColor = .buttonDestructive
            titleLabel.textColor = .red
            rightImageView.tintColor = .red
            rightImageView.tintColor = .red
        case .normal:
            backgroundColor = .background
            titleLabel.textColor = .black
            rightImageView.tintColor = .black
            leftImageView.tintColor = .black
        }
    }
}
