//
//  LoadingAccessory.swift
//  Queue
//
//  Created by Derek Nguyen on 12/4/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit
import Lottie

class LoadingAccessory: UIView, AlertAccessoryView {
    
    var height: CGFloat {
        return 100.0
    }
    
    var message: String!

    @IBOutlet weak var loadingBarView: AnimationView!
    @IBOutlet weak var messageLabel: UILabel!
    
    func loadView() {
        loadingBarView.animation = Animation.named("loadingBar")
        loadingBarView.loopMode = .loop
        loadingBarView.contentMode = .scaleToFill
        messageLabel.text = message
        registerAppActivityObserver()
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
        self.loadingBarView.pause()
    }
    
    @objc private func handleBecomeActive() {
        self.loadingBarView.play()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
