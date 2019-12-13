import UIKit
import Lottie

class AlertServiceController: UIViewController {
    
    enum AlertStyle {
        case Loading
        case Alert
    }
    
    private var curStyle: AlertStyle!
    private var text: (title: String?, message: String?)
    private var alertAction: (title: String?, state: QueueAppButton.Style, handler: (() -> Void)?)!
    
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
    
    
    // MARK: - IBOUTLETS
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var continueBtn: QueueUI.Button!
    @IBOutlet weak var continueBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var distanceToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var tapGestureView: UIView!
    
    // MARK: - IBACTIONS
    @IBAction func continueBtnTouched(_ sender: QueueUI.Button) {
        if let alertAction = alertAction, let handler = alertAction.handler {
            handler()
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissBtnTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func overlayViewDidTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContentView()
        registerAppActivityObserver()
        
        // Add an dimmer overlay to the current window
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(overlayView)
        }
    }
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleBecomeActive()
        
        // Animate the overlay appearance along with present transition
        self.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.overlayView.alpha = 1.0
        }, completion: nil)
    }
    
    // MARK: - ViewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Animate the overlay disappreance along with dismiss transtion
        self.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.overlayView.alpha = 0.0
        }, completion: { _ in
            self.overlayView.removeFromSuperview()
        })
    }
    
    // MARK: - ViewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - View Setup Code
    private func setupContentView() {
        animationView.animation = Animation.named("loadingBar")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleToFill
        titleLabel.text = text.title
        messageLabel.text = text.message
        
        switch curStyle {
        case .Alert:
            animationView.isHidden = true
            continueBtn.isHidden = false
            continueBtn.alpha = 1.0
            continueBtn.setButton(title: alertAction!.title, style: alertAction!.state)
            distanceToBottomConstraint.constant = 84.0
        case .Loading:
            tapGestureView.isHidden = true
            continueBtn.isHidden = true
            continueBtn.alpha = 0.0
            dismissBtn.isHidden = true
            distanceToBottomConstraint.constant = 16.0
        case .none: fatalError("Alert Service style have not been set")
        }
    }
    
    private func registerAppActivityObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    @objc private func handleEnterBackground() {
        self.animationView.pause()
    }
    
    @objc private func handleBecomeActive() {
        self.animationView.play()
    }
    
    private func prepareAlert() {
        animationView.pause()
        animationView.isHidden = true
        titleLabel.text = text.title
        messageLabel.text = text.message
        dismissBtn.isHidden = false
        view.layoutSubviews()
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
            [weak self] in
            guard let this = self else { return }
            this.continueBtn.isHidden = false
            this.continueBtn.setButton(title: this.alertAction!.title, style: this.alertAction!.state)
            this.distanceToBottomConstraint.constant = 84.0
            this.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
            [weak self] in
            self?.continueBtn.alpha = 1.0
        }, completion: nil)
    }
    
    private func prepareLoading() {
        tapGestureView.isHidden = true
        continueBtn.alpha = 0.0
        view.layoutSubviews()
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
            [weak self] in
            guard let this = self else { return }
            this.titleLabel.text = this.text.title
            this.messageLabel.text = this.text.message
            this.animationView.isHidden = false
            this.continueBtn.isHidden = false
            this.dismissBtn.isHidden = true
            this.distanceToBottomConstraint.constant = 16.0
            this.view.layoutSubviews()
        }) {
            [weak self] _ in
            self?.animationView.play()
        }
    }
}

extension AlertServiceController {
    
    static func makeAlertController() -> AlertServiceController {
        let sb = UIStoryboard(name: "AlertServiceController", bundle: .main)
        let vc = sb.instantiateViewController(withIdentifier: "AlertServiceController") as! AlertServiceController
        return vc
    }
    
    public func setText(title: String?, message: String?) {
        text = (title?.uppercased(), message)
    }
    
    public func setAlertAction(title: String?, state: QueueAppButton.Style, handler: (() -> Void)? = nil) {
        alertAction = (title?.uppercased(), state, handler)
    }
    
    public func present(as style: AlertStyle, in parentVC: UIViewController, completion: (() -> Void)? = nil) {
        curStyle = style
        parentVC.present(self, animated: true, completion: completion)
    }
    
    private func switchStyle(as style: AlertStyle) {
        curStyle = style
        switch curStyle {
        case .Alert: prepareAlert()
        case .Loading: prepareLoading()
        case .none: fatalError("Alert Service style have not been set")
        }
    }
    
    public func switchToLoading(title: String?, message: String?) {
        text = (title?.uppercased(), message)
        switchStyle(as: .Loading)
    }
    
    public func switchToAlert(
        title: String?, message: String?,
        buttonTitle: String?, buttonStyle: QueueAppButton.Style, completion: (() -> Void)? = nil
    ) {
        text = (title?.uppercased(), message)
        alertAction = (buttonTitle?.uppercased(), buttonStyle, completion)
        switchStyle(as: .Alert)
    }
}


