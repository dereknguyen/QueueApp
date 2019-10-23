//
//  CustomViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/22/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        removeBackButtonLabel()
    }
    
    func setupNavigationBar() {
        let backImage = Icons.leftArrow?.withAlignmentRectInsets(UIEdgeInsets(top: 20, left: -4, bottom: 10, right: 0))
        navigationController?.navigationBar.barTintColor = Colors.background
        navigationController?.navigationBar.backgroundColor = Colors.background
        navigationController?.navigationBar.tintColor = Colors.tintColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
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
