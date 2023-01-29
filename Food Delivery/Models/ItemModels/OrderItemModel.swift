//
//  OrderItemModel.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 28.01.2023.
//

import Foundation

class OrderItemModel: Hashable {
    
    var menuItem: MenuItemModel
    var amount: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(menuItem)
    }
    static func == (lhs: OrderItemModel, rhs: OrderItemModel) -> Bool {
        return lhs.menuItem == rhs.menuItem
    }
    
    init(menuItem: MenuItemModel, amount: Int) {
        self.menuItem = menuItem
        self.amount = amount
    }
    
    func changeAmount(amount: Int) {
        self.amount = amount
    }
}

#if DEBUG

extension OrderItemModel {
    static var mockData = [
        OrderItemModel(menuItem: MenuItemModel.mockData[0], amount: 1)
    ]
}

#endif
