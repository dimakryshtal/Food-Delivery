//
//  PromoModel.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 13.01.2023.
//

import Foundation

struct PromoModel: Hashable {
    var image: String
}

extension PromoModel {
    static var mockData = [
        PromoModel(image: "beef-burger")
    ]
}
