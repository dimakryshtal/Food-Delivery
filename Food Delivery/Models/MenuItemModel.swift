//
//  MenuItemModel.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 15.01.2023.
//

import Foundation


struct MenuItemModel: Hashable {
    var title: String
    var type: FoodTypes
    var description: String
    var price: Double
    var img: String
}

#if DEBUG

extension MenuItemModel {
    static var mockData = [
        MenuItemModel(title: "Pizza", type: FoodTypes.pizza, description: "Parmesan, peach, sour cream, steak", price: 5.99, img: "pizza"),
        MenuItemModel(title: "Pizza", type: FoodTypes.pizza, description: "Bacon, cheese, tomato sauce, mushrooms, pepperoni", price: 5.00, img: "pizza"),
        MenuItemModel(title: "Pizza", type: FoodTypes.pizza, description: "Bacon, cheese, tomato sauce, mushrooms, pepperoni", price: 4.00, img: "pizza"),
        MenuItemModel(title: "Burger", type: FoodTypes.burger, description: "Buns, beef patty, sauce, tomato, salad, cheese", price: 4.00, img: "burger")
    ]
}

#endif
