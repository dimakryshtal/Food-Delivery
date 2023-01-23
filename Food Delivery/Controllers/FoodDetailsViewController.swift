//
//  FoodDetailsViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 22.01.2023.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    
    var image: UIImage?
    var label: String = "Some food"
    var ingredients: String = "Some ingredients"

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodIngredientsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodLabel.text = label
        foodImage.image = image
        foodIngredientsLabel.text = ingredients

        
        foodImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    

    @IBAction func addToCart(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
