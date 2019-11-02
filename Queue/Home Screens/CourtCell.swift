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
            Colors.background.cgColor,
            Colors.background.cgColor,
            UIColor.lightGray.cgColor
        ])
    }()
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var courtNameLabel: UILabel!
    @IBOutlet weak var courtFormatLabel: UILabel!
    @IBOutlet weak var courtWaitingCountLabel: UILabel!
    @IBOutlet weak var courtWaitingCountCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        courtWaitingCountCardView.layer.cornerRadius = 3
        gradientLayer.frame = cardView.bounds
        gradientLayer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            setSelected()
        }
        else {
            setUnselected()
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            cardView.backgroundColor = UIColor.lightGray
        }
        else {
            cardView.backgroundColor = Colors.background
        }
    }
    
    private func setSelected() {
        cardView.layer.insertSublayer(gradientLayer, at: 0)
        courtWaitingCountCardView.backgroundColor = Colors.background
    }
    
    private func setUnselected() {
        gradientLayer.removeFromSuperlayer()
        courtWaitingCountCardView.backgroundColor = #colorLiteral(red: 0.9007651806, green: 0.9007651806, blue: 0.9007651806, alpha: 1)
    }
    
    
    
}
