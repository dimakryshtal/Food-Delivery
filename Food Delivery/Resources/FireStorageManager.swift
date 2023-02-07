//
//  FireStorageManager.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 07.02.2023.
//

import UIKit
import FirebaseStorage

class FireStorageManager {
    static let shared = FireStorageManager()
    
    let storage = Storage.storage()
}

extension FireStorageManager {
    func getPicture(imageTitle: String, completion: @escaping (UIImage?) -> Void) {
        let pathRef = storage.reference(withPath: "foodImages/\(imageTitle)")
        
        pathRef.getData(maxSize: 4 * 1024 * 1024) { foodImage, error in
            if let error {
                print(error)
            } else {
                let image = UIImage(data: foodImage!)
                completion(image)
            }
        }
    }
}
