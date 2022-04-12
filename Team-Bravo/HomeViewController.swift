//
//  HomeViewController.swift
//  Team-Bravo
//
//  Created by Kolton Quinton on 3/8/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func transitionToSellers() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.CreateEventVC) as? CreateEventVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func transitionToBuyers() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.EventDetailsVC) as? EventDetailsVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet weak var buyers: UIButton!
    @IBOutlet weak var sellers: UIButton!
    
    
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
