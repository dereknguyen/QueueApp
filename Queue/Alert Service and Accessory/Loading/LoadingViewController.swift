import UIKit
import Lottie

class LoadingViewController: UIViewController {

    private let loadingAnimation = "loadingBar"
    private var loadingTitle: String?
    private var loadingMessage: String?
    
    // The overlay view to be added to superview.
    private lazy var overlayView: UIView = {
        let bounds = UIScreen.main.bounds
        let frame = CGRect(x: bounds.origin.x, y: bounds.origin.y - 100,
                           width: bounds.width, height: bounds.height + 100)
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.alpha = 0.0
        return view
    }()
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var contentView: UIView!
    
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
}




