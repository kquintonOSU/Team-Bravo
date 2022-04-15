//
//  SignUpViewController.swift
//  Team-Bravo
//
//  Created by Kolton Quinton on 3/8/22.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    var firebaseID: String = ""
    
    struct addUserAPIResponse: Decodable{
        var JSONResponse: Bool
        var IsQueryExecuted: Bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false {
            return "Invalid password"
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        homeViewController?.firebaseID = firebaseID
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func addUsertoCSXDB(firstName: String, lastName: String, firebaseID: String, email: String){
        let modifiedEmail = email.str_replace(thisString: ".", withthisString: "*--DOT--*")
        let parameterString = "/" + firstName + "/" + lastName + "/" + firebaseID + "/" + modifiedEmail
        
        let urlString =  "https://cs.okstate.edu/~akarjik/addUserAPI.php" + parameterString
        guard let url = URL(string: urlString)
        else
        {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url)
        {(data, response, error) -> Void in
            // Check to see if any error was encountered.
            guard error == nil  else {
                print("URL Session error: \(error!)")
                return
            }
            // Check to see if we received any data.
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                // Decoding the JSON response in the JSONResponse structure.
                let jsonResponse = try JSONDecoder().decode(addUserAPIResponse.self,
                                                            from: data)
                if jsonResponse.IsQueryExecuted == false{
                    print("Error In ADDUSERAPI. PLEASE CHECK AGAIN")
                }else{
                    print("=============== User Added to CSX DB")
                }
            } catch let error as NSError {
                print("Error serializing JSON Data: \(error)")
            }
            
        }
        task.resume()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                self.firebaseID = result?.user.uid ?? "UID ERROR"
                if err != nil {
                    self.showError("Error creating user")
                }
                else {
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname" : firstName, "lastname" : lastName, "uid" : result!.user.uid]) { error in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                        
                    }
                    self.addUsertoCSXDB(firstName: firstName, lastName: lastName, firebaseID: result?.user.uid ?? "UID ERROR", email: email)

                    self.transitionToHome()
                }
            }
        }
        
    }
}


extension String
{
    func str_replace(thisString: String, withthisString: String) -> String
    {
        return self.replacingOccurrences(of: thisString, with: withthisString, options: NSString.CompareOptions.literal, range: nil)
    }
}
