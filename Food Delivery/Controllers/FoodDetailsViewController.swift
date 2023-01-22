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
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addToCart(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
