//
//  CourtSettingsTableViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 12/9/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class CourtSettingsTableViewController: QueueUI.TableViewController {

    private var sectionName = ["Name", "Status", "Format", "Actions", "Danger Zone"]
    private var footerMessage = ["", "Disabling a court will clear on court and waiting list.", "Changing court format will clear on court and waiting list.", "", ""]
    
    var clubName: String!
    
    private var courtFormat: [(icon: UIImage?, format: String)] = [(Icons.singlePlayer, "Single"), (Icons.partner, "Double")]
    private var courtActions: [(icon: UIImage?, action: String)] = [(Icons.xSmall, "Clear Queue"), (Icons.deletePlayer, "Remove Queue Entry")]
    
    private var headerCellID = "Section Header"
    private var footerCellID = "Section Footer"
    private var basicSettingCellID = "Basic Setting"
    private var courtStatusCellID = "Switch Control"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }

    func registerNibs() {
        tableView.register(UINib(nibName: "SectionHeaderCell", bundle: .main), forCellReuseIdentifier: headerCellID)
        tableView.register(UINib(nibName: "SectionFooterCell", bundle: .main), forCellReuseIdentifier: footerCellID)
        tableView.register(UINib(nibName: "BasicSettingCell", bundle: .main), forCellReuseIdentifier: basicSettingCellID)
        tableView.register(UINib(nibName: "SwitchControlCell", bundle: .main), forCellReuseIdentifier: courtStatusCellID)
    }
    
    func setupSwitchControl(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: courtStatusCellID, for: indexPath) as! SwitchControlCell
        cell.set(onTitle: "Enabled", offTitle: "Disabled")
        return cell
    }
    
    func setupBasicSetting(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: basicSettingCellID, for: indexPath) as! BasicSettingCell
        
        switch indexPath.section {
        case 0:
            cell.configure(title: clubName,
                           leftImage: Icons.edit,
                           rightImage: Icons.rightAngleBracket)
        case 2:
            cell.configure(title: courtFormat[indexPath.row].format,
                           leftImage: courtFormat[indexPath.row].icon)
        case 3:
            cell.configure(title: courtActions[indexPath.row].action,
                           leftImage: courtActions[indexPath.row].icon,
                           rightImage: Icons.rightAngleBracket)
        case 4:
            cell.configure(title: "DELETE COURT",
                           rightImage: Icons.rightAngleBracket,
                           style: .destructive)
        default: break
        }
        
        return cell
    }
}

// MARK: - Table view data source
extension CourtSettingsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (2...3).contains(section) ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0
        default:
            return 40.0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 4 { return UIView() }
        let footer = tableView.dequeueReusableCell(withIdentifier: footerCellID) as! SectionFooterCell
        footer.messageLabel.text = footerMessage[section]
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: headerCellID) as! SectionHeaderCell
        header.sectionLabel.text = sectionName[section]
        header.separatorView.backgroundColor = (section == 4) ? .clear : .buttonDisabled
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            return setupSwitchControl(tableView: tableView, for: indexPath)
        }
        return setupBasicSetting(tableView: tableView, for: indexPath)
    }
}

extension CourtSettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
