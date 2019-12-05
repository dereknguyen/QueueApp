//
//  CourtCell.swift
//  Queue
//
//  Created by Derek Nguyen on 10/31/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class CourtCell: UITableViewCell {
    lazy var gradientLayer: CAGradientLayer = {
        return generateGradient(colors: [
//            UIColor.background.cgColor,
            UIColor.QueueAppBlue.withAlphaComponent(1.0).cgColor,
            UIColor.QueueAppViolet.withAlphaComponent(1.0).cgColor
//            UIColor.lightGray.cgColor
        ])
    }()
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var courtNameLabel: UILabel!
    @IBOutlet weak var courtFormatLabel: UILabel!
    @IBOutlet weak var waitCountLabel: UILabel!
    @IBOutlet weak var waitCountBox: UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        containerView.layer.cornerRadius = 5
        waitCountBox.layer.cornerRadius = 3
        
        gradientLayer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            cardView.alpha = 0.2
        }
        else {
            cardView.alpha = 1.0

        }
    }

//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        if highlighted {
//            cardView.backgroundColor = UIColor.lightGray
//        }
//        else {
//            cardView.backgroundColor = .background
//        }
//    }
    
    private func setSelected() {
        gradientLayer.frame = containerView.frame
        containerView.layer.insertSublayer(gradientLayer, at: 0)
        waitCountBox.backgroundColor = .background
    }
    
    private func setUnselected() {
        gradientLayer.removeFromSuperlayer()
        waitCountBox.backgroundColor = #colorLiteral(red: 0.9007651806, green: 0.9007651806, blue: 0.9007651806, alpha: 1)
    }
}
