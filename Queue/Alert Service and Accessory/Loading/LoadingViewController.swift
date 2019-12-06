import UIKit
import Lottie

class LoadingViewController: UIViewController {

    private let loadingAnimation = "loadingBar"
    private var loadingTitle: String?
    private var loadingMessage: String?
    private var completionTitle: String!
    private var completionMessage: String!
    private var completionButtonTitle: String!
    private var completionHandler: (() -> Void)!
    
    
    // The overlay view to be added to superview.
    private lazy var overlayView: UIView = {
        let bounds = UIScreen.main.bounds
        let frame = CGRect(x: bounds.origin.x, y: bounds.origin.y - 100,
                           width: bounds.width, height: bounds.height + 100)
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.alertBackgroundOverlay
        view.alpha = 0.0
        return view
    }()
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var continueBtn: QueueUI.Button!
    @IBOutlet weak var continueBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var distanceToBottomConstraint: NSLayoutConstraint!
    
    @IBAction func continueBtnTouched(_ sender: QueueUI.Button) {
        if let handler = completionHandler {
            handler()
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContentView()
        registerAppActivityObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        handleBecomeActive()
        
        // Animate the overlay appearance along with present transition
        self.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.overlayView.alpha = 1.0
        }, completion: nil)
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
    
    // MARK: - Privates Methods
    
    private func setupContentView() {
        animationView.animation = Animation.named(loadingAnimation)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleToFill
        titleLabel.text = loadingTitle
        messageLabel.text = loadingMessage
        
        continueBtn.isHidden = true
        continueBtn.alpha = 0.0
        distanceToBottomConstraint.constant = 16.0
    }
    
    private func registerAppActivityObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func handleEnterBackground() {
        self.animationView.pause()
    }
    
    @objc private func handleBecomeActive() {
        self.animationView.play()
    }
    
    // MARK: - Public Methods
    
    public func setContent(title: String?, message: String?) {
        loadingTitle = title
        loadingMessage = message
    }
    
    /// Present **Alert Controller** in parent's view with a dimming overlay.
    /// - parameter in: The view controller that the alert will be presented in.
    public func present(in parentController: UIViewController) {
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(overlayView)
        }
        
        parentController.present(self, animated: true, completion: nil)
    }
    
    public func setCompletionAlert(
        title: String?,
        message: String?,
        buttonTitle: String?,
        handler: (() -> Void)? = nil
    ) {
        completionTitle = title?.uppercased()
        completionMessage = message
        completionButtonTitle = buttonTitle
        completionHandler = handler
    }
    
    public func presentCompletion() {
        
        animationView.pause()
        titleLabel.text = completionTitle
        messageLabel.text = completionMessage
        animationView.isHidden = true
        view.layoutIfNeeded()

        continueBtn.isHidden = false
        continueBtn.setButton(title: completionButtonTitle, state: .active)
        distanceToBottomConstraint.constant = 84.0
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                [weak self] in
                self?.view.layoutIfNeeded()
            },
            completion: nil
        )
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
            [weak self] in
            self?.continueBtn.alpha = 1.0
        }, completion: nil)
    }
}




