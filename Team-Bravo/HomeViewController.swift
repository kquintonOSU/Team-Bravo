//
//  HomeViewController.swift
//  Team-Bravo
//
//  Created by Kolton Quinton on 3/8/22.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
//    let user = Auth.auth().currentUser?.displayName

    var firebaseUserID = ""
    var displayName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Welcome, \(displayName)"
        // currentUserInfo()
        
        print("======== FirebaseID: ", firebaseUserID)
        // Do any additional setup after loading the view.
    }
    
//    func currentUserInfo() {
//        if Auth.auth().currentUser != nil {
//            let user = Auth.auth().currentUser
//            if let user = user {
//                let displayName = user.displayName
//
//
//                welcomeLabel.text = "Welcome, \(displayName!)"
//            }
//        } else {
//            print("no user logged in")
//        }
//
//    }
    
    func transitionToSellers() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.CreateEventVC) as? CreateEventVC
        vc?.firebaseUserID = firebaseUserID
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func transitionToBuyers() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.ViewEventsViewController) as? ViewEventsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        //transition to event table view controller of a list of all events in the database.
        //tapping on an event on the table view will show the corresponding event details.
        //this is the last thing to complete to have a "functioning" app.
        //once we complete this, we can add styling and some things prof mentioned.
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var myEvents: UIButton!
    @IBOutlet weak var buyers: UIButton!
    @IBOutlet weak var sellers: UIButton!
    
    
    @IBAction func didSellersSelected(_ sender: Any) {
        transitionToSellers()
    }

    @IBAction func didBuyersSelected(_ sender: Any) {
        transitionToBuyers()
    }
    
    @IBAction func didMyEventsSelected(_ sender: Any) {
        //transitionToMyEvents
        //statistics for logged in users posted events
        //we are almost done
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
