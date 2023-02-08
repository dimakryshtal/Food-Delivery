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
    
    lazy var minusButton = createButton(with: "-")
    lazy var plusButton = createButton(with: "+")
    
    weak var delegate: OrderDishCellDelegate?
    var indexPath: IndexPath!
    
    var countLabel: UILabel = {
        var label = UILabel()
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        label.text = "1"
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    var priceSummary: UILabel = {
        var label = UILabel()
        label.textColor = .white
        
        label.text = "4.0$"
        
        return label
    }()
    
    var orderData: OrderItemModel? {
        didSet {
            guard let orderData else { return }
//            cellData = orderData.menuItem
            countLabel.text = String(orderData.amount)
            
        }
    }
    
    func createButton(with label: String) -> UIButton {
        let b = UIButton()
        b.layer.cornerRadius = 12.5
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor.white.cgColor
        b.setTitle(label, for: .normal)
        
        return b
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Order dish cell created")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        print("Order dish cell removed")
        
    }
    override func configure() {
        contentView.backgroundColor = UIColor(named: K.BrandColors.secondaryColor)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(foodImage)
        contentView.addSubview(plusButton)
        contentView.addSubview(countLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(priceSummary)
        
    }
    
    override func configureConstraints() {
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        priceSummary.translatesAutoresizingMaskIntoConstraints = false

        
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
            priceLabel.heightAnchor.constraint(equalToConstant: 15),
            
            plusButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 25),
            plusButton.widthAnchor.constraint(equalToConstant: 25),
            plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            countLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 35),
            countLabel.widthAnchor.constraint(equalToConstant: 25),
            countLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -2),
            
            minusButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            minusButton.heightAnchor.constraint(equalToConstant: 25),
            minusButton.widthAnchor.constraint(equalToConstant: 25),
            minusButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -2),
            
            priceSummary.centerXAnchor.constraint(equalTo: countLabel.centerXAnchor),
            priceSummary.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor)
            
        ])
    }
    
}

//MARK: - "+" AND "-" buttons
extension OrderDishCollectionViewCell {
    @objc func plusButtonTapped() {
        guard let orderData else { return }
        orderData.amount = orderData.amount + 1
        countLabel.text = "\(orderData.amount)"
    }
    
    @objc func minusButtonTapped() {
        guard let orderData, orderData.amount > 0 else { return }
        orderData.amount = orderData.amount - 1
        countLabel.text = "\(orderData.amount)"
        if orderData.amount == 0 {
            delegate?.removeCell(dish: orderData)
        }
    }
    
}
