//
//  LoadingViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/16/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {

    private let loadingAnimation = "loadingBar"
    
    private var loadingTitle: String?
    private var loadingMessage: String?
    
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
        showContentView()
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Overrides
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            [weak self] in
            guard let this = self else { return }
            this.contentView.transform = CGAffineTransform(translationX: 0.0, y: this.contentView.frame.height)
        }, completion: { _ in
            super.dismiss(animated: true, completion: completion)
        })
    }
    
    // MARK: - Privates
    
    private func setupContentView() {
        contentView.transform = CGAffineTransform(translationX: 0.0, y: contentView.frame.height)
        
        animationView.animation = Animation.named(loadingAnimation)
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        
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
    
    private func showContentView() {
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
            [weak self] in
            self?.contentView.transform = .identity
        }, completion: nil)
    }
    
    public func setContent(title: String, message: String) {
        loadingTitle = title
        loadingMessage = message
    }
}




