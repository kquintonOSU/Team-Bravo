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
        }
    }
    
    @IBAction func didCancelSelected(_ sender: Any) {
        self.Goback()
    }
    
    
    @IBAction func didSelectStartDate(_ sender: Any) {
        showDateAndTimePicker( mode: UIDatePicker.Mode.date)
        type = 1
    }
    @IBAction func didSelectStartTime(_ sender: Any) {
        showDateAndTimePicker(mode: UIDatePicker.Mode.time)
        type = 1
    }
    @IBAction func didSelectEndDate(_ sender: Any) {
        showDateAndTimePicker(mode: UIDatePicker.Mode.date)
        type = 2
    }
    @IBAction func didSelectEndTime(_ sender: Any) {
        showDateAndTimePicker(mode: UIDatePicker.Mode.time)
        type = 2
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
        
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        datePicker.backgroundColor = UIColor.white
        self.view.addSubview(datePicker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.backgroundColor = UIColor.white
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
        }
        
        if(self.mode == UIDatePicker.Mode.time){
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .medium
            if ( type == 1) {
                //Starting Time
                if let date = sender?.date {
                    self.tfStartTime.text = "\(dateFormatter.string(from: date))"
                }
            } else {
                //Ending Time
                if let date = sender?.date {
                    self.tfEndTime.text = "\(dateFormatter.string(from: date))"
                }
            }
        }else{
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            if( type == 1){
                //Starting Date
                if let date = sender?.date {
                    self.tfStartDate.text = "\(dateFormatter.string(from: date))"
                }
            }else{
                //Ending Date
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
        self.view.removeFromSuperview()
        if let nev = self.navigationController{
            
            nev.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    func validation() -> Bool {
        if(tfEventNanme.text == ""){
            self.showToast(message: "Event Name is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        if(tfDescriptionn.text == ""){
            self.showToast(message: "Event Description is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        if(tfStartDate.text == ""){
            self.showToast(message: "Event Starting Date is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        if(tfStartTime.text == ""){
            self.showToast(message: "Event Starting Time is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        
        if(tfEndDate.text == ""){
            self.showToast(message: "Event Ending Date is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        if(tfEndTime.text == ""){
            self.showToast(message: "Event Ending Time is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        
        if(tfLocationDetails.text == ""){
            self.showToast(message: "Event Location details is required!", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        
        
        return true
    }
    
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
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
        let db = Firestore.firestore()
        
        db.collection("events").addDocument(data: ["event_name" : tfEventNanme.text, "event_description" : tfDescriptionn.text,"start_date" : tfStartDate.text, "start_time" : tfStartTime.text,"end_date" : tfEndDate.text, "end_time" : tfEndTime.text, "location" : tfLocationDetails.text ]) { error in
            if error != nil {
                self.showToast(message: "Error while saving Event!", font: .systemFont(ofSize: 12.0))
            }else{
                self.showToast(message: "Event Created Successfully!", font: .systemFont(ofSize: 12.0))
            }
        }
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

