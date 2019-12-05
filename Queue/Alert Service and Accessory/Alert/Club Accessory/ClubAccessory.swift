import UIKit

class ClubAcessory: UIView, AlertAccessoryView {
    
    var height: CGFloat {
        return 100.0
    }
    
    private var name: String!
    private var id: String!
    private var logo: UIImage!
    
    @IBOutlet private weak var clubLogoImageView: UIImageView!
    @IBOutlet private weak var clubNameLabel: UILabel!
    @IBOutlet private weak var clubIDLabel: UILabel!
    
    func configure(logo: UIImage?, name: String, id: String) {
        self.logo = logo
        self.name = name
        self.id = id
    }
    
    func loadView() {
        clubLogoImageView.image = logo
        clubLogoImageView.layer.cornerRadius = 6.0
        
        clubNameLabel.text = name
        clubIDLabel.text = "ID: " + id
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

