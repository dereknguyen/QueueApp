//
//  ClubTableViewController.swift
//  Queue
//
//  Created by Derek Nguyen on 10/31/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class ClubTableViewController: QueueAppTableViewController {
    
    @IBOutlet weak var gymSelectionButton: UIButton!
    @IBOutlet weak var partnerSelectionButton: UIButton!
    @IBOutlet weak var optionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partnerSelectionButton.layer.borderColor = UIColor.textColor.cgColor
        partnerSelectionButton.layer.borderWidth = 1
        partnerSelectionButton.layer.cornerRadius = 11
        
        gymSelectionButton.layer.cornerRadius = 11
        gymSelectionButton.setImage(UIImage(named: "CP"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @IBAction func clubSettingTouched(_ sender: UIButton) {
        performSegue(withIdentifier: "toClubSetting", sender: nil)
    }
    
    @IBAction func selectPartnerTouched(_ sender: UIButton) {
        let alert = AlertServiceController.makeAlertController()
        alert.setText(title: "TEST ALERT SERVICES", message: "Loading will take about 2 seconds.")
        alert.setAlertAction(title: "Okay", state: .active) {
            alert.switchToLoading(title: "LOADING BIG TIME", message: "Loading for 2 seconds.")
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                DispatchQueue.main.async {
                    alert.switchToAlert(title: "Loading is done", message: "Should be working now", buttonTitle: "Done", buttonStyle: .active)
                }
            }
        }
        
        alert.present(as: .Alert, in: self)
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourtCell", for: indexPath) as! CourtCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "GymToQueue", sender: indexPath)
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    
}
