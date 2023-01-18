//
//  FoodCategoryModel.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 14.01.2023.
//

import Foundation

struct FoodCategoryModel {
    let categoryName: String
    let categoryImage: String
}

#if DEBUG

extension FoodCategoryModel {
    static let mockData = [
        FoodCategoryModel(categoryName: "Pizza", categoryImage: "pizza-slice"),
        FoodCategoryModel(categoryName: "Burger", categoryImage: "burger"),
        FoodCategoryModel(categoryName: "Salad", categoryImage: "salad"),
        FoodCategoryModel(categoryName: "Snacks", categoryImage: "fried-potatoes"),
        FoodCategoryModel(categoryName: "Drinks", categoryImage: "soft-drink")
        
    ]
}
#endif
