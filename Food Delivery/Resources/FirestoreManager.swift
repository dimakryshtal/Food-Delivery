//
//  FirestoreManager.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 06.02.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    static let shared = FirestoreManager()
    
    let db = Firestore.firestore()
}

extension FirestoreManager {
    func createUserInDB(userID: String, firstName: String, lastName: String) {
        let docRef = db.document("userNames/\(userID)")
        docRef.setData(["firstName": firstName, "lastName": lastName])
    }
    func createNewOrder(order: Set<OrderItemModel>) {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonResultData = try jsonEncoder.encode(OrderItemModel.mockData[0])
            try db.collection("orders").document().setData(from: ["orderList": Array(order)])
            
        } catch {
            print(error)
        }
        
    }
    
// FIXME: implement escaping closure
    
    func getAllDishes(completion: @escaping ([MenuItemModel]) -> Void){
        db.collection("dishes").getDocuments { query, error in
            if let error {
                print(error)
                return
            }

            let menu: [MenuItemModel] = query!.documents.map { document in
                
                do {
                    let menuItem = try document.data(as: MenuItemData.self)
                    return MenuItemModel(id: document.documentID, data: menuItem)
                } catch {
                    print(error)
                }
                return MenuItemModel(id: "0", data: MenuItemData(title: "", type: .burger, description: "", price: 0, image: ""))
            }
            completion(menu)



        }
    }
}
