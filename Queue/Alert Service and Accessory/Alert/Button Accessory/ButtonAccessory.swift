import UIKit

class ButtonAccessory: UIView, AlertAccessoryView {
    
    enum Style {
        case destructive
        case normal
        case active
        case disabled
    }
    
    var height: CGFloat {
        return 65.0
    }
    
    private var title: String!
    private var image: UIImage!
    private var style: ButtonAccessory.Style!
    private var handler: (() -> Void)!
    
    @IBOutlet weak var button: QueueAppButton!
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        handler()
    }
    
    func loadView() {
        switch style {
        case .active:      button.setButton(state: .active)
        case .destructive: button.setButton(state: .destructive)
        case .disabled:    button.setButton(state: .disabled)
        default:           button.setButton(state: .normal)
        }
        
        if let image = image {
            button.setImage(image, for: .normal)
        }
        else {
            button.setImage(nil, for: .normal)
        }
        
        button.setTitle(title.uppercased(), for: .normal)
    }
    
    func configure(title: String, style: ButtonAccessory.Style, image: UIImage? = nil, handler: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.style = style
        self.handler = handler
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
