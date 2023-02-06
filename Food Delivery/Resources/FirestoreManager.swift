//
//  FirestoreManager.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 06.02.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    static let shared = FirestoreManager()
    
    let database = Firestore.firestore()
}

extension FirestoreManager {
    func createUserInDB(userID: String, firstName: String, lastName: String) {
        print("called")
        let docRef = database.document("userNames/\(userID)")
        docRef.setData(["firstName": firstName, "lastName": lastName])
    }
}
