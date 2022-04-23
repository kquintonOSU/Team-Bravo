//
//  MyEventsViewController.swift
//  Team-Bravo
//
//  Created by Ranjith Shaganti on 4/22/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myEventsTableView: UITableView!
    
    var getListOfEvents: Array<String> = Array()
    var ticketsbooked: Array<Int> = Array()
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //x=db_yash.database().reference().child("")
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print(userID)
    
        let db = Firestore.firestore()
        db.collection("events").getDocuments { snapshot,error in
            if error == nil {
                if let snapshot = snapshot {
                    snapshot.documents.map { d in
                        if(userID == d["FirebaseUserID"] as! String){
    
                            self.getListOfEvents.append(d["event_name"]! as! String)
                            self.ticketsbooked.append(d["number_of_bookings"] as! Int)
                            
    
                        }
                        self.myEventsTableView.reloadData()
                    
                    }
                }
                
            }
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getListOfEvents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(getListOfEvents)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCells", for: indexPath)
        cell.textLabel?.text = getListOfEvents[indexPath.row] //writing statename in the tableview cell
        print(cell)
        return cell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? chartsViewController {
            //dest.section_ = indexPath[0]
            dest.ticketsbooked = ticketsbooked
            dest.getListOfEvents = getListOfEvents
        }
        
    }
    
}
