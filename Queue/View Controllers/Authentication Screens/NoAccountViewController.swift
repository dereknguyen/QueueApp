//
//  NoAccountViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/23/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class NoAccountViewController: QueueUI.ViewController {

    @IBOutlet weak var contBtn: QueueUI.Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contBtn.setButton(state: .active)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.popViewController(animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Removing self from navigation stack.
        // User does not need to see this screen again if they go back.
        if var vcStack = navigationController?.viewControllers {
            vcStack.remove(at: 2)
            navigationController?.viewControllers = vcStack
        }
    }
}
