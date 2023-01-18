//
//  UILabel + Extension.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 15.01.2023.
//

import UIKit

extension UILabel {
    func createAppLabel(of size: Int) -> UILabel {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(named: "secondaryColor")
        
        return label
    }
}
