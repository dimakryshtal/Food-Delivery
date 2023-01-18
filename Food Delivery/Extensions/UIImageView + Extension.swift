//
//  UIImageView + Extension.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 15.01.2023.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        layer.cornerRadius = self.bounds.height / 2
        layer.borderWidth = 0
        layer.masksToBounds = false
        
    }
}
