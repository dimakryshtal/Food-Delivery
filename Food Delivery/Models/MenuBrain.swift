//
//  MenuBrain.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 26.01.2023.
//

import Foundation

class MenuBrain {
    private var currentOrder: Set<OrderItemModel> = []
    
    private var foodData: [MenuItemModel]
    private var promoData: [PromoModel]
    private var categories: [FoodCategoryModel]
    
    var selectedCategoryItem: FoodTypes = .pizza
    
    init() {
        foodData = MenuItemModel.mockData
        promoData = PromoModel.mockData
        categories = FoodCategoryModel.mockData
    }
    
    func addToCart(dish: MenuItemModel) {
        currentOrder.insert(OrderItemModel(menuItem: dish, amount: 1))
    }
    func removeFromCart(dish: OrderItemModel) {
        currentOrder.remove(dish)
    }
    
    func checkIfOrderContains(dish: MenuItemModel) -> Bool {
        return currentOrder.contains(OrderItemModel(menuItem: dish, amount: 1))
    }
    
    
}

//MARK: - Get Methods
extension MenuBrain {
    func getFoodData() -> [MenuItemModel] {
        return foodData
    }
    
    func getCategories() -> [FoodCategoryModel] {
        return categories
    }
    
    func getPromos() -> [PromoModel] {
        return promoData
    }
    func getCurrentOrder() -> Set<OrderItemModel> {
        return currentOrder
    }
}
