//
//  ProfileViewController.swift
//  Team-Bravo
//
//  Created by Abdulla Karjikar on 4/22/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var email_ = ""
    var firstName_ = ""
    var LastName_ = ""
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var LastName: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.text = emailLabel.text! + " " + email_
        firstName.text = firstName.text! + " " + firstName_
        LastName.text = LastName.text! + " " + LastName_


        // Do any additional setup after loading the view.
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
