//
//  EventDetailsVC.swift
//  Team-Bravo
//
//  Created by Aishwarya Anmol on 4/11/22.
//

import Foundation
import UIKit

class EventDetailsVC: UIViewController {
    @IBOutlet weak var tfEventNanme: UITextField!
    @IBOutlet weak var tfDescriptionn: UITextField!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfStartTime: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var tfEndTime: UITextField!
    @IBOutlet weak var tfLocationDetails: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self .title = "Event Details"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didBackSelected(_ sender: Any) {
        self.Goback()
    }
    @IBAction func didBookSelected(_ sender: Any) {
       
    }
    
    @IBAction func didCancelSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    func Goback() {
        if let nev = self.navigationController {
            
            nev.popViewController(animated: true)
        } else{
            self.dismiss(animated: true, completion: nil)
        }
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
