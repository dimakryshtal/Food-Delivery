//
//  ViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 13.01.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartButton: UIButton!
    
    private lazy var dataSource = makeDataSource()
    
    var selectedCategoryItem: FoodTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(PromoCollectionViewCell.self, forCellWithReuseIdentifier: PromoCollectionViewCell.cellIdentifier)
        collectionView.register(FoodCategoryCollectionViewCell.self, forCellWithReuseIdentifier: FoodCategoryCollectionViewCell.cellIdentifier)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.cellIdentifier)
        collectionView.register(MenuHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MenuHeader.menuHeaderIdentifier)
        
        setLayout()
        applySnapshot()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
}

//MARK: - Seting Layout
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

//MARK: - DataSource and Snapshot
extension MenuViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<MenuViewLayout.Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MenuViewLayout.Section, AnyHashable>
    
    private func makeDataSource() -> DataSource{
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            if let promo = item as? PromoModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCollectionViewCell.cellIdentifier, for: indexPath) as? PromoCollectionViewCell
                cell?.cellData = promo
                return cell
            } else if let category = item as? FoodCategoryModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCollectionViewCell.cellIdentifier, for: indexPath) as? FoodCategoryCollectionViewCell
                cell?.cellData = category
                return cell
            } else if let menu = item as? MenuItemModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.cellIdentifier, for: indexPath) as? MenuCollectionViewCell
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
            let currentData = MenuItemModel.mockData.filter { menuItem in
                menuItem.type == selectedCategoryItem
            }
            
            
            snapshot.appendSections([.menu(foodType: selectedCategoryItem)])
            snapshot.appendItems(currentData, toSection: .menu(foodType: selectedCategoryItem))
        }
        dataSource.apply(snapshot)
    }
}

//MARK: - Delegate
extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            deselectAllItems(in: 1)
        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedCategoryItem = (dataSource.snapshot(for: .category).items[indexPath.item] as! FoodCategoryModel).categoryName
            
            applySnapshot()
        } else if indexPath.section == 2 {
            self.performSegue(withIdentifier: "foodDetails", sender: collectionView.cellForItem(at: indexPath))
            deselectAllItems(in: 2)
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


//MARK: - Segues
extension MenuViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodDetails" {
            guard let vc = segue.destination as? FoodDetailsViewController else {
                fatalError("Cannot typecast to FoodDetailsViewControlles")
            }
            
            guard let cell = sender as? MenuCollectionViewCell else {
                fatalError("Cannot typecast to MenuCollectionViewCell")
            }
            var cellData = cell.cellData
            

            
            vc.label = cellData?.title ?? ""
            vc.ingredients = cellData?.description ?? ""
            vc.image = UIImage(named: cellData?.img ?? "")
        }
    }
}

