//
//  UITextView + Extension.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 31.01.2023.
//

import UIKit

extension UITextView {
    func centerVertically() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}
