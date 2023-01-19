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
        
        collectionView.allowsMultipleSelection = true
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
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        layout.configuration = config
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
            return 10
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
            cell.cellData = MenuItemModel.mockData[0]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: MenuHeader.menuHeaderIdentifier,
                                                                     for: indexPath) as! MenuHeader
        header.label.text = "Category 1"
        
        return header
    }
}

extension MenuViewController {
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            deselectAllItems(in: 1)
        }
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            return false
        }
        return true
    }
}

extension MenuViewController {
    func deselectAllItems(in section: Int) {
        let selectedItems = collectionView.indexPathsForSelectedItems ?? []
        
        for item in selectedItems {
            if item.section == section {
                collectionView.deselectItem(at: item, animated: true)
            }
        }
    }
}

