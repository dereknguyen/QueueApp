//
//  GreetingViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/22/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class GreetingViewController: QueueUI.ViewController {

    @IBOutlet weak var logoQImageView: UIImageView!
    @IBOutlet weak var logoUEUEImageView: UIImageView!
    @IBOutlet weak var getStartedBtn: UIButton!
    @IBOutlet weak var btnUnderbarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLaunchScreenUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Check authentication
        showGetStartedUI()
    }
    
    private func showLaunchScreenUI() {
        logoUEUEImageView.alpha = 0
        logoUEUEImageView.isHidden = true
        getStartedBtn.alpha = 0
        btnUnderbarView.alpha = 0
        btnUnderbarView.transform = CGAffineTransform(translationX: 0, y: 20)
    }
    
    private func showGetStartedUI() {
        // Animating unhide the "ueue" will cause "Q" to translate left
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.8, options: [], animations: {
            [weak self] in
            self?.logoUEUEImageView.isHidden = false
        }, completion: nil)
        
        // We want to animate "ueue" alpha with a delay so Q won't overlapping as it translates
        UIView.animateKeyframes(withDuration: 0.6, delay: 1.0, options: [], animations: {
            [weak self] in
            self?.logoUEUEImageView.alpha = 1
        }, completion: nil)

        // "GET STARTED" animation
        UIView.animate(withDuration: 0.8, delay: 1.6, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            [weak self] in
            self?.getStartedBtn.alpha = 1
            self?.btnUnderbarView.alpha = 1
            self?.btnUnderbarView.transform = .identity
        }, completion: nil)
    }
}
