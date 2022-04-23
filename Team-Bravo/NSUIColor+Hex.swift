//
//  NSUIColor+Hex.swift
//  Team-Bravo
//
//  Created by Ranjith Shaganti on 4/22/22.
//

import Foundation
import Charts
import UIKit

extension NSUIColor {
    convenience init(red: Int, green: Int, blue: Int)
    {
        assert(red >= 0 && red <= 255, "Invalid red")
        assert(green >= 0 && green <= 255, "Invalid green")
        assert(blue >= 0 && blue <= 255, "Invalid blue")
        
        self.init(red:CGFloat(red)/255.0, green:CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
        
    }
    convenience init(hex: Int)
    {
        self.init(red: (hex >> 16) & 0xFF,
                  green: (hex >> 16) & 0xFF,
                  blue: hex & 0xFF)
    }
}
