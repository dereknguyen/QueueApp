import UIKit

protocol AlertAccessoryView: UIView {
    var height: CGFloat { get }
    func loadView() 
}

class AlertController: UIViewController {

    private var accessories = [AlertAccessoryView]()
    
    // The overlay view to be added to superview.
    private lazy var overlayView: UIView = {
        let bounds = UIScreen.main.bounds
        let frame = CGRect(x: bounds.origin.x, y: bounds.origin.y - 100,
                           width: bounds.width, height: bounds.height + 100)
        let view = UIView(frame: frame)
        view.backgroundColor = .alertBackgroundOverlay
        view.alpha = 0.0
        return view
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accessoryStackView: UIStackView!
    @IBOutlet weak var accessoryStackViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // When user tap outside of container view, dismiss the view.
    @IBAction func viewDidTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accessoryStackViewHeightConstraint.constant = calcStackHeight()
        arrangeAccessoryStack()
        titleLabel.text = title?.uppercased()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Animate the overlay appearance along with present transition
        self.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.overlayView.alpha = 1.0
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Animate the overlay disappreance along with dismiss transtion
        self.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.overlayView.alpha = 0.0
        }, completion: { _ in
            self.overlayView.removeFromSuperview()
        })
    }
    
    // Calculate the total height of the stack
    private func calcStackHeight() -> CGFloat {
        var totalHeight: CGFloat = 0.0
        accessories.forEach { totalHeight += $0.height }
        return totalHeight
    }
    
    // Anchor the height of each accessory and add them to stack
    private func arrangeAccessoryStack() {
        accessories.forEach {
            [weak self] view in
            guard let this = self else { return }
            view.heightAnchor.constraint(equalToConstant: view.height).isActive = true
            DispatchQueue.main.async {
                this.accessoryStackView.addArrangedSubview(view)
                view.loadView()
            }
        }
    }
    
    /// Present **Alert Controller** in parent's view with a dimming overlay.
    /// - parameter in: The view controller that the alert will be presented in.
    func present(in parentController: UIViewController) {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(overlayView)
        }
        
        parentController.present(self, animated: true, completion: nil)
    }
    
    /// Attach an **AlertAccessoryView**  object to the alert controller.
    /// If there are multiple accessories, the accessories will be displayed in the added order.
    /// - parameter accessory: The **AlertAccessoryView** object to display as part of the allert.
    func addAccessory(_ accessory: AlertAccessoryView) {
        accessories.append(accessory)
    }
}

