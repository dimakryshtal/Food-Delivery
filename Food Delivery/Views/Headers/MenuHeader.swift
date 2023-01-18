//
//  MenuHeader.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 17.01.2023.
//

import UIKit

class MenuHeader: UICollectionViewCell {
    static let menuHeaderIdentifier = "MenuHeaderCollectionViewCell"
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.secondaryColor)
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
    
    func configure() {
        contentView.backgroundColor = UIColor(named: K.BrandColors.mainColor)
        contentView.addSubview(label)
    }
    
    func configureConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
        label.centerView(to: self, horizontally: false, vertically: true)
        
    }
    

}
