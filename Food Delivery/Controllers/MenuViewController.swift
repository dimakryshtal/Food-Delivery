//
//  ViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 13.01.2023.
//

import UIKit

class MenuViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private lazy var dataSource = makeDataSource()
    
    var selectedCategoryItem: FoodTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.allowsMultipleSelection = true
        collectionView.register(PromoCollectionViewCell.self, forCellWithReuseIdentifier: PromoCollectionViewCell.cellIdentifier)
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: FoodCategoryCell.ceilIdentifier)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.cellIdenfitier)
        collectionView.register(MenuHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MenuHeader.menuHeaderIdentifier)
        
        setLayout()
        applySnapshot()
        
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
    
    private func makeDataSource() -> DataSource{
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            if let promo = item as? PromoModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCollectionViewCell.cellIdentifier, for: indexPath) as? PromoCollectionViewCell
                cell?.cellData = promo
                return cell
            } else if let category = item as? FoodCategoryModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCell.ceilIdentifier, for: indexPath) as? FoodCategoryCell
                cell?.cellData = category
                return cell
            } else if let menu = item as? MenuItemModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.cellIdenfitier, for: indexPath) as? MenuCollectionViewCell
                cell?.cellData = menu
                return cell
            }
            return nil
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: MenuHeader.menuHeaderIdentifier,
                                                                         for: indexPath) as! MenuHeader
            
            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]

            if case let .menu(foodType) = section {
                header.label.text = foodType.rawValue
            }
            return header

        }
        
        return dataSource
    }
    
    
    
    func applySnapshot(animatingDifferences: Bool = true) {
        
        var snapshot = Snapshot()
        
        snapshot.appendSections([.promo, .category])
        
        snapshot.appendItems(PromoModel.mockData, toSection: .promo)
        snapshot.appendItems(FoodCategoryModel.mockData, toSection: .category)
        
        
        if let selectedCategoryItem {
            var currentData = MenuItemModel.mockData.filter { menuItem in
                menuItem.type == selectedCategoryItem
            }
            
            
            snapshot.appendSections([.menu(foodType: selectedCategoryItem)])
            snapshot.appendItems(currentData, toSection: .menu(foodType: selectedCategoryItem))
        }
        dataSource.apply(snapshot)
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
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedCategoryItem = (dataSource.snapshot(for: .category).items[indexPath.item] as! FoodCategoryModel).categoryName
            
            applySnapshot()
        }
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

