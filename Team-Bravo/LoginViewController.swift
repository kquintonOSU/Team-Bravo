//
//  LoginViewController.swift
//  Team-Bravo
//
//  Created by Kolton Quinton on 3/8/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    var firebaseUserID = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! HomeViewController
        homeViewController.firebaseUserID = firebaseUserID
        let navigationController = UINavigationController(rootViewController: homeViewController)
        view.window?.rootViewController = navigationController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                print("======== FirebaseID: In Authentication: ", result?.user.uid)
                self.firebaseUserID = result?.user.uid ?? "UIDERROR"
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    self.transitionToHome()
                }
                
            }
        }
    }
}
