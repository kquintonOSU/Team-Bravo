//
//  CreateEventVC.swift
//  Team-Bravo
//
//  Created by Aishwarya Anmol on 4/11/22.
//

import Foundation
import UIKit
import Firebase

class CreateEventVC: UIViewController {
    
    var firebaseUserID = ""
    
    @IBOutlet weak var tfEventNanme: UITextField!
    @IBOutlet weak var tfDescriptionn: UITextField!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfStartTime: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var tfEndTime: UITextField!
    @IBOutlet weak var tfLocationDetails: UITextField!
    
    var datePicker  = UIDatePicker()
    var toolBar = UIToolbar()
    var mode : UIDatePicker.Mode = UIDatePicker.Mode.time
    var type = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CreateEventVC: ", firebaseUserID)
        tfEventNanme.delegate = self // set delegate
        tfDescriptionn.delegate = self // set delegate
        tfStartDate.delegate = self // set delegate
        tfStartTime.delegate = self // set delegate
        tfEndDate.delegate = self // set delegate
        tfEndTime.delegate = self // set delegate
        tfLocationDetails.delegate = self // set delegate

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didBackSelected(_ sender: Any) {
        self.Goback()
    }
    @IBAction func didSubmitSelected(_ sender: Any) {
        if(validation()){
            submitEventToFirebase()
            self.Goback()
        }
    }
    
    @IBAction func didCancelSelected(_ sender: Any) {
        self.Goback()
    }
    
    
    @IBAction func didSelectStartDate(_ sender: Any) {
        type = 1
        showDateAndTimePicker( mode: UIDatePicker.Mode.date)
      
    }
    @IBAction func didSelectStartTime(_ sender: Any) {
        type = 1
        showDateAndTimePicker(mode: UIDatePicker.Mode.time)
      
    }
    @IBAction func didSelectEndDate(_ sender: Any) {
        type = 2
        showDateAndTimePicker(mode: UIDatePicker.Mode.date)
       
    }
    @IBAction func didSelectEndTime(_ sender: Any) {
        type = 2
        showDateAndTimePicker(mode: UIDatePicker.Mode.time)
       
    }
    
    func showDateAndTimePicker(mode : UIDatePicker.Mode){
        self.mode = mode
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = mode
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = .current
      
        if(self.mode == UIDatePicker.Mode.date){
            if type == 1{
                datePicker.minimumDate = Date()
            }else{
                datePicker.minimumDate = self.startTime

            }
        }else{
            
            if startDate == Date(){
                datePicker.minimumDate = Date()
            }
        }

        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        datePicker.backgroundColor = UIColor.white
        self.view.addSubview(datePicker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.backgroundColor = UIColor.white
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    var startTime = Date()
    var startDate = Date()
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
       

        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
        }
        
        if(self.mode == UIDatePicker.Mode.time){
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .medium
            if( type == 1){
                //Starting Time
                self.startTime = datePicker.date
                dateFormatter.dateFormat = "h:mm a"
                if let date = sender?.date {
                    self.tfStartTime.text = "\(dateFormatter.string(from: date))"
                }
            }else{
                //Ending Time
                dateFormatter.dateFormat = "h:mm a"
                if let date = sender?.date {
                    self.tfEndTime.text = "\(dateFormatter.string(from: date))"
                }
            }
        }else{
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            if( type == 1){
                //Starting Date
                self.startTime = datePicker.date
                self.startDate = datePicker.date
//                dateFormatter.dateFormat = "MM/dd/yyyy"
                if let date = sender?.date {
                    self.tfStartDate.text = "\(dateFormatter.string(from: date))"
                }
            }else{
                //Ending Date
//                dateFormatter.dateFormat = "MM/dd/yyyy"
                if let date = sender?.date {
                    self.tfEndDate.text = "\(dateFormatter.string(from: date))"
                }
            }
        }
    }
    
    @objc func onDoneButtonClick() {
        self.dateChanged(_:datePicker)
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    
    func Goback() {
        if let nev = self.navigationController{
            
            nev.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func validation() -> Bool {
        if(tfEventNanme.text == ""){
            //self.showToast(message: "Event Name is required!", font: .systemFont(ofSize: 12.0))
            showAlert(message_: "Event Name is required!")
            return false
        }
        
        if(tfDescriptionn.text == ""){
            //self.showToast(message: "Event Description is required!", font: .systemFont(ofSize: 12.0))
            showAlert(message_: "Event Description is required!")
            return false
        }
        
        if(tfStartDate.text == ""){
            //self.showToast(message: "Event Starting Date is required!", font: .systemFont(ofSize: 12.0))
            showAlert(message_: "Event Starting Date is required!")
            return false
        }
        
        if(tfStartTime.text == ""){
            //self.showToast(message: "Event Starting Time is required!", font: .systemFont(ofSize: 12.0))
            showAlert(message_: "Event Starting Time is required!")
            return false
        }
        
        if(tfEndDate.text == ""){
            //self.showToast(message: "Event Ending Date is required!", font: .systemFont(ofSize: 12.0))
            showAlert(message_: "Event Ending Date is required!")
            return false
        }
        
        if(tfEndTime.text == ""){
            //self.showToast(message: "Event Ending Time is required!", font: .systemFont(ofSize: 12.0))
            showAlert(message_: "Event Ending Time is required!")
            return false
        }
        
        if(tfLocationDetails.text == ""){
            showAlert(message_: "Event Location details is required!")
            //self.showToast(message: "Event Location details is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        // Adding code to make sure end date and time is not before start data and time
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        let end_date_ = tfEndDate.text!//"Apr 21, 2022"
        let end_time_d = tfEndTime.text!//"12:29 PM"
        let end_time_seperated = end_time_d.components(separatedBy: ":")
        let end_part = end_time_seperated[end_time_seperated.count-1].components(separatedBy: " ")
        let end_time_ = end_time_seperated[0] + ":" + end_time_seperated[1].components(separatedBy: " ")[0] + " " + end_part[end_part.count-1]
        let endDateTime = end_date_ + " " + end_time_
        print("endDateTime: ", endDateTime)
        let start_date_ = tfStartDate.text!//"Apr 21, 2022"
        let start_time_d = tfStartTime.text!//"12:45 PM"
        let start_time_seperated = start_time_d.components(separatedBy: ":")
        let end_part_ = start_time_seperated[start_time_seperated.count-1].components(separatedBy: " ")
        let start_time_ = start_time_seperated[0] + ":" + start_time_seperated[1].components(separatedBy: " ")[0] + " " + end_part_[end_part_.count-1]
        let startDateTime = start_date_ + " " + start_time_//"Apr 16, 2022 3:41:48 PM"
        //let datecomponents = dateFormatter.date(from: startDateTime)!
        print("startDateTime: ", startDateTime)
        let startDateComponent = dateFormatter.date(from: startDateTime)!
        let endDateComponent = dateFormatter.date(from: endDateTime)!
        if(startDateComponent > endDateComponent){
            showAlert(message_: "Event end data and time cannot be earlier than start date and Time!")
            return false
        }
        return true
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
    
    func submitEventToFirebase(){
        print("UID: \(UUID().uuidString)")
        let db = Firestore.firestore()
        db.collection("events").addDocument(data: ["id" : UUID().uuidString, "event_name" : self.tfEventNanme.text!, "event_description" : self.tfDescriptionn.text!,"start_date" : self.tfStartDate.text!, "start_time" : self.tfStartTime.text!,"end_date" : self.tfEndDate.text!, "end_time" : self.tfEndTime.text!, "location" : self.tfLocationDetails.text!, "number_of_bookings" : 0, "FirebaseUserID": firebaseUserID ]) { error in
            if error != nil {
                self.showToast(message: "Error while saving Event!", font: .systemFont(ofSize: 12.0))
            }else{
                self.showToast(message: "Event Created Successfully!", font: .systemFont(ofSize: 12.0))
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            }
        }
    }
    
    func showAlert(message_: String){
        let alert = UIAlertController(title: "Validation Error", message: message_, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
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


extension CreateEventVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
