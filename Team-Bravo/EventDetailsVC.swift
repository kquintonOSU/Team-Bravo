//
//  EventDetailsVC.swift
//  Team-Bravo
//
//  Created by Aishwarya Anmol on 4/11/22.
//

import Foundation
import UIKit
import Firebase

class EventDetailsVC: UIViewController {
    @IBOutlet weak var tfEventNanme: UITextField!
    @IBOutlet weak var tfDescriptionn: UITextField!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfStartTime: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var tfEndTime: UITextField!
    @IBOutlet weak var tfLocationDetails: UITextField!
    @IBOutlet weak var tfNoOfSeats: UITextField!
    
    var event : FirebaseEvent? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNoOfSeats.delegate = self // set delegate

        // Do any additional setup after loading the view.
        self .title = "Event Details"
        tfEventNanme.text = "\(event?.event_name ?? "")"
        tfDescriptionn.text = "\(event?.event_description ?? "")"
        tfStartDate.text = "\(event?.start_date ?? "")"
        tfStartTime.text = "\(event?.start_time ?? "")"
        tfEndDate.text = "\(event?.end_date ?? "")"
        tfEndTime.text = "\(event?.end_time ?? "")"
        tfLocationDetails.text = "\(event?.location ?? "")"
    }
    
    
    @IBAction func didBackSelected(_ sender: Any) {
        self.Goback()
    }
    @IBAction func didBookSelected(_ sender: Any) {
        if(validation()){
            updateEventToFirebase()
        }
    }
    
    @IBAction func didCancelSelected(_ sender: Any) {
        //        self.Goback()
        self.navigationController?.popViewController(animated: true)
    }
    func Goback() {
        if let nev = self.navigationController{
            
            nev.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: 40, y: self.view.frame.size.height-100, width: (view.frame.size.width - 80), height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Event
    struct Event: Decodable {
        var EID: String
        var org_id: String
        var date: String
        var description: String
        var start_time: String
        var end_time: String
        var location: String
    }
    
    func validation() -> Bool {
        if(tfNoOfSeats.text == ""){
            self.showToast(message: "No of seats field is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        let seats = NumberFormatter().number(from: self.tfNoOfSeats.text!) as! Int
        if( seats > 5 || seats < 1){
            self.showToast(message: "Number of seats can be between 1 to 5!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        return true
    }
    
    func updateEventToFirebase(){
        let seats = NumberFormatter().number(from: self.tfNoOfSeats.text!) as! Int
        let db = Firestore.firestore()
        
        db.collection("events")
            .whereField("event_name", isEqualTo: "\(event?.event_name ?? "")")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print( "Some error occured" + err.localizedDescription)
                } else if querySnapshot!.documents.count != 1 {
                    // Perhaps this is an error for you?
                    print( "Perhaps this is an error for you?" )
                } else {
                    let bookings = (self.event!.number_of_bookings + seats)
                    let document = querySnapshot!.documents.first
                    document!.reference.updateData([
                        "number_of_bookings": bookings
                    ])
                    print("Seats \(bookings)")
                    self.showToast(message: "Event Booked Successfully!", font: .systemFont(ofSize: 12.0))
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                }
            }
    }
}


extension EventDetailsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
