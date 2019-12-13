import UIKit

class CourtSettingCell: UITableViewCell {
    
    enum ButtonStyle {
        case destructive
        case normal
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var waitingCountLabel: UILabel!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rightImageView.image = Icons.rightAngleBracket
    }
    
    func configure(court name: String, format: String, waiting: String) {
        titleLabel.text = name
        formatLabel.text = format
        waitingCountLabel.text = waiting
        backgroundColor = .background
    }
    
    func configureAsButton(title: String, style: CourtSettingCell.ButtonStyle) {
        detailStackView.isHidden = true
        titleLabel.text = title
        
        switch style {
        case .destructive:
            backgroundColor = .buttonDestructive
            titleLabel.textColor = .red
            rightImageView.tintColor = .red
        case .normal:
            backgroundColor = .background
            titleLabel.textColor = .black
            rightImageView.tintColor = .black
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rightImageView.isHidden = showsReorderControl ? true : false
    }
}

