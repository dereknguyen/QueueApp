//
//  SectionHeaderCell.swift
//  Queue
//
//  Created by Derek Nguyen on 12/6/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

protocol ClubSettingHeaderDelegate {
    func clubSettingHeader(didTappedEditAt section: Int, sender: UIButton)
}

class SectionHeaderCell: UITableViewCell {
    
    var delegate: ClubSettingHeaderDelegate?
    var section: Int?
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.isHidden = true
    }
    
    func configureEditing(title: String? = nil, isEnabled: Bool) {
        editButton.setTitle(title ?? "Edit", for: .normal)
        if isEnabled {
            editButton.isHidden = false
        }
        else {
            editButton.isHidden = true
        }
    }
    
    @IBAction func editDidTapped(_ sender: UIButton) {
        if let delegate = delegate, let section = section {
            delegate.clubSettingHeader(didTappedEditAt: section, sender: sender)
        }
    }
}
