import UIKit

class ActionSheetController: UIViewController {

    /// The title of the action sheet. Use this to grab user attention.
    var prompt: String?
    
    private var actions: [(title: String, action: () -> Void)] = []
    
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
    
    @IBOutlet weak var tapGestureView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func dismissBtnTouched(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func dimmingVIewDidTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        actionTableView.dataSource = self
        actionTableView.delegate = self
        tapGestureView.addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(dimmingVIewDidTapped))
        )
        
        setupContainerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    private func setupContainerView() {
        titleLabel.text = prompt
        tableViewHeightConstraint.constant = CGFloat(actions.count * 70)
    }
    
    /// Present in parent's view with a dimming overlay.
    /// - parameter in: The view controller that the alert will be presented in.
    func present(in parentController: UIViewController) {

        if let window = UIApplication.shared.keyWindow {
            window.addSubview(overlayView)
        }
        
        parentController.present(self, animated: true, completion: nil)
    }
    
    /// Add an action to the action sheet.
    /// - parameter title: The title of the action. Make it short and descriptive.
    /// - parameter handler: The block to execute when user select this action. The block has no return value.
    func addAction(title: String, handler: @escaping () -> Void) {
        actions.append((title, handler))
    }
}

extension ActionSheetController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actions[indexPath.row].action()
    }
}

extension ActionSheetController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actionCell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as! ActionTableCell
        actionCell.actionLabel.text = actions[indexPath.row].title
        return actionCell
    }
}
