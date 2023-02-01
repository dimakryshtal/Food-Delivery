//
//  FoodDetailsViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 22.01.2023.
//

import UIKit


class FoodDetailsViewController: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodIngredientsLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var image: UIImage?
    var label: String = "Some food"
    var ingredients: String = "Some ingredients"
    var isAlreadyChosen: Bool = false
    
    
    var cellData: MenuItemModel!
    var delegate: DataSendingDelegate?
    
    deinit {
        print("OrderViewController deinitialized")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodLabel.text = cellData?.title
        
        foodImage.image = UIImage(named: cellData?.img ?? "")
        foodImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        foodIngredientsLabel.text = cellData?.description
    
        
        addToCartButton.isEnabled = !isAlreadyChosen
        addToCartButton.setImage(isAlreadyChosen ? nil : UIImage(systemName: "cart"), for: .normal)
        addToCartButton.setTitle(isAlreadyChosen ? "The dish has already been chosen" : "Add to cart: \(cellData.price)$", for: .normal)
        
        
        addToCartButton.setTitleColor(.white, for: .disabled)
        
        
    }
    

    @IBAction func addToCart(_ sender: UIButton) {
        guard let cellData else {fatalError("Food details data is nil")}
        delegate?.sendDataToMenuViewController(data: cellData)
        self.dismiss(animated: true)
    }
}
