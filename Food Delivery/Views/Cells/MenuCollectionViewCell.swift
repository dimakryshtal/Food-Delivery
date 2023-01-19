//
//  MenuCollectionViewCell.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 15.01.2023.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let cellIdenfitier = "MenuCollecionViewCell"
    
    var cellData : MenuItemModel? {
        didSet {
            guard let cellData = cellData else {return}
            titleLabel.text = cellData.title
            descriptionLabel.text = cellData.description
            priceLabel.text = "\(cellData.price)$"
            foodImage.image = UIImage(named: cellData.img)
        }
    }
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(named: K.BrandColors.mainColor)
        
        return label
    }()
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(named: K.BrandColors.mainColor)
        
        return label
    }()
    var priceLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(named: K.BrandColors.mainColor)
        
        return label
    }()
    var foodImage: UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 10
        
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.transform = self.isSelected ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure() {
        contentView.backgroundColor = UIColor(named: K.BrandColors.secondaryColor)
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
        
        
        foodImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 110).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        foodImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: foodImage.leftAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: foodImage.leftAnchor, constant: 5).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: foodImage.leftAnchor, constant: 5).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
