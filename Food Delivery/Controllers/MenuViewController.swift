//
//  ViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 13.01.2023.
//

import UIKit

class MenuViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(PromoCollectionViewCell.self, forCellWithReuseIdentifier: PromoCollectionViewCell.cellIdentifier)
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: FoodCategoryCell.ceilIdentifier)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.cellIdenfitier)
        collectionView.register(MenuHeader.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: MenuHeader.menuHeaderIdentifier)
        
        setLayout()
        
    }


    
}

extension MenuViewController {
    func setLayout() {
        let layout = UICollectionViewCompositionalLayout{ sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return MenuViewLayout.shared.promosLayout()
            case 1:
                return MenuViewLayout.shared.categoriesLayout()
            case 2:
                return MenuViewLayout.shared.menuLayout()
            default:
                return MenuViewLayout.shared.promosLayout()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension MenuViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return PromoModel.mockData.count
        case 1:
            return FoodCategoryModel.mockData.count
        case 2:
            return MenuItemModel.mockData.count
        default:
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCollectionViewCell.cellIdentifier, for: indexPath) as? PromoCollectionViewCell else {fatalError("Unable to deque cell.")}
            cell.cellData = PromoModel.mockData[indexPath.row]
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCell.ceilIdentifier, for: indexPath) as? FoodCategoryCell else {fatalError("Unable to deque cell.")}
            cell.cellData = FoodCategoryModel.mockData[indexPath.row]
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.cellIdenfitier, for: indexPath) as? MenuCollectionViewCell else {fatalError("Unable to deque cell.")}
            cell.cellData = MenuItemModel.mockData[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == "header" {
//            switch indexPath.section {
//            default:
//                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                             withReuseIdentifier: MenuHeader.menuHeaderIdentifier,
//                                                                             for: indexPath) as! MenuHeader
//                header.label.text = "Category 1"
//
//                return header
//            }
//        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: MenuHeader.menuHeaderIdentifier,
                                                                     for: indexPath) as! MenuHeader
        header.label.text = "Category 1"
        
        return header
    }
}

