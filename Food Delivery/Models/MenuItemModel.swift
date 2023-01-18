//
//  MenuItemModel.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 15.01.2023.
//

import Foundation

struct MenuItemModel {
    var title: String
    var description: String
    var price: Double
    var img: String
}

#if DEBUG

extension MenuItemModel {
    static var mockData = [
        MenuItemModel(title: "Pizza", description: "Bacon, cheese, tomato sauce, mushrooms, pepperoni", price: 5.99, img: "pizza")
    ]
}

#endif
