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



    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Welcome to Reserva"
        // Do any additional setup after loading the view.
    }
    
    func transitionToSellers() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.CreateEventVC) as? CreateEventVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func transitionToBuyers() {
        //transition to event table view controller of a list of all events in the database.
        //tapping on an event on the table view will show the corresponding event details.
        //this is the last thing to complete to have a "functioning" app.
        //once we complete this, we can add styling and some things prof mentioned.
    }
    
    @IBOutlet weak var buyers: UIButton!
    @IBOutlet weak var sellers: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    @IBAction func didSellersSelected(_ sender: Any) {
        transitionToSellers()
    }

    @IBAction func didBuyersSelected(_ sender: Any) {
        transitionToBuyers()
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
