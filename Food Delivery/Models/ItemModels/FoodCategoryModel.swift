//
//  FoodCategoryModel.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 14.01.2023.
//

import Foundation

enum FoodTypes: String, Codable {
    case pizza = "Pizza"
    case salad = "Salad"
    case snacks = "Snacks"
    case burger = "Burger"
    case drink = "Drink"
}

struct FoodCategoryModel: Hashable {
    let categoryName: FoodTypes
    let categoryImage: String
}

#if DEBUG

extension FoodCategoryModel {
    static let mockData = [
        FoodCategoryModel(categoryName: FoodTypes.pizza, categoryImage: "pizza-slice"),
        FoodCategoryModel(categoryName: FoodTypes.burger, categoryImage: "burger"),
        FoodCategoryModel(categoryName: FoodTypes.salad, categoryImage: "salad"),
        FoodCategoryModel(categoryName: FoodTypes.snacks, categoryImage: "fried-potatoes"),
        FoodCategoryModel(categoryName: FoodTypes.drink, categoryImage: "soft-drink")
        
    ]
}
#endif
