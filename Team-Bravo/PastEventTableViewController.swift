//
//  PastEventTableViewController.swift
//  Team-Bravo
//
//  Created by Abdulla Karjikar on 4/15/22.
//

import UIKit

class PastEventTableViewController: UITableViewController {

    @IBOutlet var TV: UITableView!
    
    var firebasedata = [FirebaseEvent]()
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        TV.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return firebasedata.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell

        let data = firebasedata[indexPath[1]]
        let st_time_sep = data.start_time.split(separator: ":")
        let st_time = st_time_sep[0] + ":" + st_time_sep[1] + " " + st_time_sep[2].split(separator: " ")[1]
        let end_time_sep = data.end_time.split(separator: ":")
        let end_time = end_time_sep[0] + ":" + end_time_sep[1] + " " + end_time_sep[2].split(separator: " ")[1]
        let eventTime = st_time + " - " + end_time
        let st_date = data.start_date.split(separator: " ")
        let month = st_date[0].uppercased()
        let date = st_date[1].replacingOccurrences(of: ",", with: "")

        cell.configure(eventName_: data.event_name, eventTime_: eventTime, month_: month, date_: date)

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    

}
