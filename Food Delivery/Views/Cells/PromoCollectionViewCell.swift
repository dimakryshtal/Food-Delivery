//
//  PromoCollectionViewCell.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 13.01.2023.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "FoodTopBannerCollectionViewCell"
    
    var cellData : PromoModel? {
        didSet {
            guard let cellData = cellData else {return}
            bannerImage.image = UIImage(named: cellData.image)
        }
    }
    
    
    let bannerImage : UIImageView = {
        let bI = UIImageView()
        bI.translatesAutoresizingMaskIntoConstraints = false
        bI.backgroundColor = .systemBackground
        bI.clipsToBounds = true
        bI.contentMode = .scaleAspectFill
        bI.layer.cornerRadius = 40
        bI.layer.borderWidth = 5
        bI.layer.borderColor = UIColor(named: K.BrandColors.secondaryColor)?.cgColor
        return bI
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure(){
        contentView.backgroundColor = .clear
        contentView.addSubview(bannerImage)
        bannerImage.setConstraints(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
