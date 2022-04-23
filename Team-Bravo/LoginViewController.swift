//
//  LoginViewController.swift
//  Team-Bravo
//
//  Created by Kolton Quinton on 3/8/22.
//

import UIKit
import FirebaseAuth
import Firebase


public struct UserData: Identifiable{
    public var id: String = UUID().uuidString
    var displayName: String
    var firstname: String
    var lastname: String
    var uid: String
}




class LoginViewController: UIViewController {
    var firebaseUserID = ""
    var _email_ = ""
    var firstName = ""
    var displayName = ""
    var lastName = ""
    var firebasedata = [UserData]()


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDataFromFirebase{
            data in
            self.firebasedata = data
        }
        

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
        setUserDetails()
        homeViewController.firebaseUserID = firebaseUserID
        homeViewController.firstName = firstName
        homeViewController.lastName = lastName
        homeViewController.email_ = _email_
        //print("============================ ", firstName, "   ", lastName)
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
                self._email_ = email
                //print("LOGIN----------- ", result?.user.displayName)
                
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
    
    func setUserDetails(){
        for eachUserDetails in firebasedata{
            if eachUserDetails.uid == firebaseUserID{
                displayName = eachUserDetails.displayName
                firstName = eachUserDetails.firstname
                lastName = eachUserDetails.lastname
            }
        }
    }
    
    
    
    func fetchUserDataFromFirebase(comp: @escaping ([UserData])->()){
        let db = Firestore.firestore()
        firebasedata = []
        db.collection("users").addSnapshotListener{(querySnapshot, error) in
            self.firebasedata.removeAll()
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            
            var localFirebaseData = [UserData]()
            
            localFirebaseData = documents.map{(queryDocumentSnapshot) -> UserData in
                let data = queryDocumentSnapshot.data()
                let uid_ = data["uid"] as? String ?? ""
                let fName = data["firstname"] as? String ?? ""
                let lName = data["lastname"] as? String ?? ""
                let dName = data["displayName"] as? String ?? ""

                //print("fetchfromUSERs === ", self.displayName, " ** ", self.lastName, " ** ", self.firstName)
                
                return UserData(displayName: dName, firstname: fName, lastname: lName, uid: uid_)
            }
            
            comp(localFirebaseData)
        }
    }
    
}
