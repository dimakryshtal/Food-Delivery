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
    
    
    let imagesCache = NSCache<NSString, UIImage>()
    let storage = Storage.storage()
}

extension FireStorageManager {
    func getPicture(imageTitle: String, completion: @escaping (UIImage?) -> Void) {
        
        if let image = imagesCache.object(forKey: imageTitle as NSString) {
            print("Retrieved image from cache")
            completion(image)
            
            return
        }
        
        let pathRef = storage.reference(withPath: "foodImages/\(imageTitle)")
        
        pathRef.getData(maxSize: 4 * 1024 * 1024) { foodImage, error in
            if let error {
                print(error)
            } else {
                let image = UIImage(data: foodImage!)
                self.imagesCache.setObject(image!, forKey: imageTitle as NSString)
                completion(image)
            }
        }
    }
}
