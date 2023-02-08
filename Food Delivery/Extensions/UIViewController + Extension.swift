//
//  UIViewController + Extension.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 08.02.2023.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        print("Tapped")
        view.endEditing(true)
    }
    
}
