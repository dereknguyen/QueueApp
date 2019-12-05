//
//  ConfirmFoundClubViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 12/4/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class ConfirmFoundClubViewController: QueueUI.ViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var clubTitleLabel: UILabel!
    @IBOutlet weak var clubIDLabel: UILabel!
    @IBOutlet weak var clubLogoImageView: UIImageView!
    @IBOutlet weak var continueBtn: QueueUI.Button!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        continueBtn.setButton(title: "Yes, This is right", state: .active)
    }
    
    @IBAction func continueBtnTouched(_ sender: QueueUI.Button) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
