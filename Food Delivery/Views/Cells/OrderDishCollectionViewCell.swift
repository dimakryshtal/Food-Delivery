//
//  OrderDishCollectionViewCell.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 24.01.2023.
//

import UIKit

class OrderDishCollectionViewCell: MenuCollectionViewCell {
    override class var cellIdentifier: String {
        return "OrderDishCollectionViewCell"
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        contentView.backgroundColor = UIColor(named: K.BrandColors.secondaryColor)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(foodImage)
    
    }
    
    override func configureConstraints() {
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            foodImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            foodImage.widthAnchor.constraint(equalToConstant: 80),
            foodImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            priceLabel.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            priceLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
}
