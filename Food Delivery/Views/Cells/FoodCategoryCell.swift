//
//  FoodCategoryCell.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 14.01.2023.
//

import UIKit

class FoodCategoryCell: UICollectionViewCell {
    static let ceilIdentifier = "FoodCategoryCollectionViewCell"
    
    var cellData : FoodCategoryModel? {
        didSet {
            guard let cellData = cellData else {return}
            cellImage.image = UIImage(named: cellData.categoryImage)
            categoryLabel.text = cellData.categoryName
        }
    }
    
    var categoryCell: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: K.BrandColors.secondaryColor)
        view.layer.cornerRadius = 29
        
        return view
    }()

    var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "pizza")

        return imageView
    }()

    var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor(named: K.BrandColors.secondaryColor)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(){
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 30
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor(named: K.BrandColors.secondaryColor)?.cgColor

        contentView.addSubview(categoryCell)
        categoryCell.addSubview(cellImage)
        contentView.addSubview(categoryLabel)
        
        

//         cellImage.setConstraints(to: self)
    }
    
    func configureConstraints() {
        categoryCell.translatesAutoresizingMaskIntoConstraints = false
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        categoryCell.heightAnchor.constraint(equalToConstant: 55),
        categoryCell.widthAnchor.constraint(equalToConstant: 55),
        categoryCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),

        cellImage.heightAnchor.constraint(equalToConstant: 55 / sqrt(2) - 5),
        cellImage.widthAnchor.constraint(equalToConstant: 55 / sqrt(2) - 5),
        categoryLabel.topAnchor.constraint(equalTo: categoryCell.bottomAnchor, constant: 10)
        ])
        categoryCell.centerView(to: self, horizontally: true, vertically: false)
        cellImage.centerView(to: categoryCell, horizontally: true, vertically: true)
        categoryLabel.centerView(to: self, horizontally: true, vertically: false)
    }
}
