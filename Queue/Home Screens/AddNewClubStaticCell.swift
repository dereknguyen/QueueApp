//
//  AddNewClubStaticCell.swift
//  Queue
//
//  Created by Derek Nguyen on 11/2/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class AddNewClubStaticCell: UITableViewCell {
    
    @IBOutlet weak var addImageContainer: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var ctaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addImageContainer.layer.borderWidth = 1.0
        addImageContainer.layer.borderColor = #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1)
        addImageContainer.layer.cornerRadius = 15
        addImageView.tintColor = #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1)
        ctaLabel.textColor = #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1)
    }
}
