//
//  ClubSettingTableViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 12/6/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class ClubSettingTableViewController: QueueUI.TableViewController {

    private let isAdmin = true
    private let headerTitle = ["Actions", "Court Settings", "Add Club", "Danger Zone"]
    private let actionRow = ["Manage Members", "Invite Members", "Leave Club"]
    private var courtName = ["Court 1", "Court 2", "Court 3"]
    private let formats = ["Double", "Double", "Double"]
    private let waitingCount = ["5", "6", "3"]
    
    private let headerReuseID = "SectionHeader"
    private let basicSettingReuseID = "BasicSetting"
    private let courtSettingReuseID = "CourtSetting"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
    }
    
    func registerNibs() {
        tableView.register(
            UINib(nibName: "SectionHeaderCell", bundle: .main),
            forCellReuseIdentifier: headerReuseID
        )
        tableView.register(
            UINib(nibName: "BasicSettingCell", bundle: .main),
            forCellReuseIdentifier: basicSettingReuseID
        )
        tableView.register(
            UINib(nibName: "CourtSettingCell", bundle: .main),
            forCellReuseIdentifier: courtSettingReuseID
        )
    }
    
    private func setupHeader(tableView: UITableView, for section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: headerReuseID) as! SectionHeaderCell
        header.sectionLabel.text = headerTitle[section]
        header.separatorView.backgroundColor = (section == 3) ? .clear : .buttonDisabled
        header.configureEditing(
            title: "Edit Order",
            isEnabled: section == 1 ? true : false
        )
        header.delegate = self
        header.section = section
        return header
    }
    
    private func setupActionCell(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: basicSettingReuseID, for: indexPath) as! BasicSettingCell
        let index = isAdmin ? indexPath.row : indexPath.row + 1
        cell.leftImageView.image = UIImage(named: actionRow[index])
        cell.titleLabel.text = actionRow[index]
        cell.rightImageView.image = Icons.rightAngleBracket
        cell.backgroundColor = .background
        return cell
    }
    
    private func setupCourtSettingCell(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: courtSettingReuseID, for: indexPath) as! CourtSettingCell
        cell.configure(
            court: courtName[indexPath.row],
            format: formats[indexPath.row],
            waiting: waitingCount[indexPath.row]
        )
        return cell
    }
    
    private func setupAddCourtButtonCell(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: courtSettingReuseID) as! CourtSettingCell
        cell.configureAsButton(title: "Add Court", style: .normal)
        return cell
    }
    
    private func setupDangerButtonCell(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: courtSettingReuseID, for: indexPath) as! CourtSettingCell
        cell.configureAsButton(title: "DELETE CLUB", style: .destructive)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCourtSetting" {
            if let destVC = segue.destination as? CourtSettingsTableViewController,
                let indexPath = sender as? IndexPath,
                let cell = tableView.cellForRow(at: indexPath) as? CourtSettingCell
            {
                destVC.clubName = cell.titleLabel.text
                destVC.title = "\(destVC.clubName ?? "") Settings"
            }
        }
    }
}

// MARK: - Table view data source
extension ClubSettingTableViewController {

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 0.0 : 40.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 1 ? 0.0 : 20.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 3:
            return 50.0
        case 1, 2:
            return 70.0
        default:
            return 0.0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setupHeader(tableView: tableView, for: section)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isAdmin ? headerTitle.count : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return isAdmin ? actionRow.count : 2
        case 1:
            return isAdmin ? courtName.count : 0
        case 2, 3:
            return isAdmin ? 1 : 0
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return setupActionCell(tableView: tableView, for: indexPath)
        case 1:
            return setupCourtSettingCell(tableView: tableView, for: indexPath)
        case 2:
            return setupAddCourtButtonCell(tableView: tableView, for: indexPath)
        case 3:
            return setupDangerButtonCell(tableView: tableView, for: indexPath)
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let fromName = courtName[fromIndexPath.row]
        courtName.remove(at: fromIndexPath.row)
        courtName.insert(fromName, at: to.row)
    }
    
    override func tableView(
        _ tableView: UITableView,
        targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
        toProposedIndexPath proposedDestinationIndexPath: IndexPath
    ) -> IndexPath {
        
        let sourceSection = sourceIndexPath.section
        let proposedSection = proposedDestinationIndexPath.section
        
        if proposedSection != sourceSection {
            return IndexPath(
                row: (proposedSection < sourceSection) ? 0 : tableView.numberOfRows(inSection: sourceSection) - 1,
                section: sourceIndexPath.section
            )
        }
        else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.section == 1) && (0...indexPath.count).contains(indexPath.row) {
            return true
        }
        else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.section == 1) && (0...indexPath.count).contains(indexPath.row) {
            return true
        }
        else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            performSegue(withIdentifier: "toCourtSetting", sender: indexPath)
        }
    }
}

extension ClubSettingTableViewController: ClubSettingHeaderDelegate {
    func clubSettingHeader(didTappedEditAt section: Int, sender: UIButton) {
        tableView.isEditing.toggle()
        sender.setTitle(tableView.isEditing ? "Done & Save" : "Edit Order", for: .normal)
    }
}
