//
//  MenuCollectionViewCell.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 15.01.2023.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    class var cellIdentifier: String {
        return "MenuCollectionViewCell"
        
    }
    
    var cellData : MenuItemModel? {
        didSet {
            guard let cellData = cellData else {return}
            titleLabel.text = cellData.title
            descriptionLabel.text = cellData.description
            priceLabel.text = "\(cellData.price)$"
            foodImage.image = nil
            FireStorageManager.shared.getPicture(imageTitle: cellData.image) { image in
                DispatchQueue.main.async {
                    self.foodImage.image = image
                }
            }
        }
    }
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        
        return label
    }()
    var priceLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        
        return label
    }()
    var foodImage: UIImageView = {
        var iv = UIImageView()
        iv.layer.cornerRadius = 10
        
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: K.BrandColors.secondaryColor)
        contentView.layer.cornerRadius = 10
        configure()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(foodImage)
        
    }
    
    func configureConstraints() {
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            foodImage.widthAnchor.constraint(equalToConstant: 90),
            foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            foodImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            foodImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: foodImage.leadingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: foodImage.leadingAnchor, constant: 5),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 5),
            priceLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
