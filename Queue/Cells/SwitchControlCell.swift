//
//  SwitchControlCell.swift
//  Queue
//
//  Created by Derek Nguyen on 12/9/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class SwitchControlCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    private var onTitle: String?
    private var offTitle: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchControl.onTintColor = .QueueAppPurple
        switchControl.setOn(true, animated: false)
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        layoutSubviews()
    }
    
    func set(onTitle: String?, offTitle: String?) {
        self.onTitle = onTitle
        self.offTitle = offTitle
        layoutSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if switchControl.isOn {
            titleLabel.text = onTitle
            titleLabel.textColor = .black
        }
        else {
            titleLabel.text = offTitle
            titleLabel.textColor = .buttonDisabled
        }
    }
}
