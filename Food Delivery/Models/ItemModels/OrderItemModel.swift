//
//  OrderItemModel.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 28.01.2023.
//

import Foundation

class OrderItemModel: Hashable, Codable{
    
    var itemID: String
    var amount: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(itemID)
    }
    static func == (lhs: OrderItemModel, rhs: OrderItemModel) -> Bool {
        return lhs.itemID == rhs.itemID
    }
    
    init(itemID: String, amount: Int) {
        self.itemID = itemID
        self.amount = amount
    }
    
    func changeAmount(amount: Int) {
        self.amount = amount
    }
}

#if DEBUG

extension OrderItemModel {
    static var mockData = [
        OrderItemModel(itemID: "0", amount: 1)
    ]
}

#endif
