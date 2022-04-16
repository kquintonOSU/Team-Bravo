//
//  CustomTableViewCell.swift
//  Team-Bravo
//
//  Created by Abdulla Karjikar on 4/13/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "reservaEventCell"
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
    public func configure(eventName_: String, eventTime_: String, month_: String, date_: String){
        eventName.text = eventName_
        eventName.font = UIFont.boldSystemFont(ofSize: 30.0)
        eventTime.text = eventTime_
        month.text = month_
        date.text = date_
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
