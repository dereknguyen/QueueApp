//
//  ClubCell.swift
//  Queue
//
//  Created by Derek Nguyen on 11/2/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class ClubCell: UITableViewCell {
    
    @IBOutlet weak var activeIndicatorView: UIView!
    @IBOutlet weak var clubLogoImageView: UIImageView!
    @IBOutlet weak var logoContainerView: UIView!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var numCourtsLabel: UILabel!
    @IBOutlet weak var numMembersLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clubLogoImageView.layer.cornerRadius = 15
        logoContainerView.layer.cornerRadius = 15
        logoContainerView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        logoContainerView.layer.shadowRadius = 5
        logoContainerView.layer.shadowOpacity = 0.1
        logoContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
