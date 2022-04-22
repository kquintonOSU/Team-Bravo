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
    
    let ran=["yash","jwewbj","cbjwcwebu"]
    
    

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
                            
                            
                            
                           // self.
                           // print(d["number_of_bookings"]!)
                           // print(d["FirebaseUserID"]!)
                           // print(d[""]!)
                        }
                        self.myEventsTableView.reloadData()
                        print(self.getListOfEvents)
                        //print(Todo(name: d["FirebaseUserID"] as! String, number: d["number_of_bookings"] as! Int))
                    }
                }
                
            }
        }
        
           // self.myEventstableView.reloadData()
        
        print(self.getListOfEvents)
        //yash()
        
       /* myEventstableView.layer.cornerRadius=10
        myEventstableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        myEventstableView.delegate = self
        myEventstableView.dataSource = self
        myEventstableView.reloadData()
*/
    
    }
    /*func yash(){
            let db = Firestore.firestore()
            db.collection("events").getDocuments { snapshot,error in
                if error == nil {
                    if let snapshot = snapshot {
                        snapshot.documents.map { d in
                            if(userID == d["FirebaseUserID"] as! String){
                                self.getListOfEvents.append(d["event_name"]! as! String)
                                //print(self.getListOfEvents)
                               // self.
                               // print(d["number_of_bookings"]!)
                               // print(d["FirebaseUserID"]!)
                               // print(d[""]!)
                            }
                            //print(Todo(name: d["FirebaseUserID"] as! String, number: d["number_of_bookings"] as! Int))
                        }
                    }
                    
                }
            }
            
        }*/
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getListOfEvents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//sleep(10)
        print("YASH")
        print(getListOfEvents)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCells", for: indexPath)
        cell.textLabel?.text = getListOfEvents[indexPath.row] //writing statename in the tableview cell
        print(cell)
        return cell
    }
    
    //override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "tableCells", sender: <#T##Any?#>)
   // }
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getListOfEvents.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let events = getListOfEvents[indexPath.row]
        cell.textLabel?.text = events
        return cell
       // guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
              // return UITableViewCell()
         //  }

          // cell.subjectList = subjectsDict[subjectArray[indexPath.row]]

         //  return cell
        
    }*/
    
}
