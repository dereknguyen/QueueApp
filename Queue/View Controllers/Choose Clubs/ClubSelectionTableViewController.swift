//
//  ClubSelectionTableViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 11/1/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class ClubSelectionTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }

    private func setupNavigationController() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        let backImage = Icons.x!.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0))
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.setupNavigationBar()
        navigationController?.navigationBar.layoutMargins.left = 16
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 { return 1 }
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        switch indexPath.section {
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddNewClubStaticCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as! ClubCell
        }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        if indexPath.section == 1 { return false }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            handleAddNewClub()
        }
    }

    func handleAddNewClub() {
        let vc = AlertService.actionSheet(title: "ADD NEW CLUB")
        vc.addAction(title: "Join existing club") {
            DispatchQueue.main.async {
                vc.dismiss(animated: true) {
                    [weak self] in
                    self?.performSegue(withIdentifier: "toJoinExistingClub", sender: nil)
                }
            }
        }
        vc.addAction(title: "Create new club") {
            DispatchQueue.main.async {
                vc.dismiss(animated: true) {
                    [weak self] in
                    self?.performSegue(withIdentifier: "toCreateNewClub", sender: nil)
                }
            }
        }
        DispatchQueue.main.async {
            vc.present(in: self)
        }
    }
}
