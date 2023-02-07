//
//  MenuBrain.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 26.01.2023.
//

import Foundation

class MenuBrain {
    private var currentOrder: Set<OrderItemModel> = []
    
    private var foodData: [MenuItemModel] = []
    private var promoData: [PromoModel]
    private var categories: [FoodCategoryModel]
    private var delegate: MenuBrainDelegate?
    
    var selectedCategoryItem: FoodTypes = .pizza
    
    init() {
        promoData = PromoModel.mockData
        categories = FoodCategoryModel.mockData
        loadData()
    }
    
    func loadData() {
        FirestoreManager.shared.getAllDishes { menu in
            self.foodData = menu
            DispatchQueue.main.async {
                self.delegate?.updateData()
            }
        }
    }
    
    func setDelegate(delegate: MenuBrainDelegate) {
        self.delegate = delegate
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
