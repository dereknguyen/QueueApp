//
//  QueueAppViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/22/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class QueueAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setBackButton(action: #selector(backAction))
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .background
        navigationController?.navigationBar.tintColor = .tintColor
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setBackButton(action: Selector? = nil) {
        let backImage = Icons.leftArrow?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0))
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func removeBackButtonLabel() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    func hideNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension QueueAppViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


