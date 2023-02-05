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
    
    static func createImageViewForTextField(with imageName: String) -> UIView {
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = UIColor(named: K.BrandColors.secondaryColor)
        
        iconContainer.addSubview(imageView)
        
        return iconContainer
    }
}
