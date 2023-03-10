//
//  ViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 13.01.2023.
//

import UIKit
import FirebaseAuth

protocol DataSendingDelegate {
    func addToCart(itemID: String)
}

protocol MenuBrainDelegate {
    func updateData()
}

class MenuViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartButton: UIButton!
    
    private lazy var dataSource = makeDataSource()
    
    var brain: MenuBrain!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirestoreManager.shared.getAllDishes { menu in
            print(menu)
        }
        
        brain.setDelegate(delegate: self)
        
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(PromoCollectionViewCell.self, forCellWithReuseIdentifier: PromoCollectionViewCell.cellIdentifier)
        collectionView.register(FoodCategoryCollectionViewCell.self, forCellWithReuseIdentifier: FoodCategoryCollectionViewCell.cellIdentifier)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.cellIdentifier)
        collectionView.register(MenuHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MenuHeader.menuHeaderIdentifier)
        
        setLayout()
        applySnapshot()
        
        collectionView.selectItem(at: IndexPath(item: 0, section: 1), animated: false, scrollPosition: [])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        configureCartButton()
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func cartButtonTapped(_ sender: Any) {
        guard brain.getCurrentOrder().count != 0 else {
            let alert = UIAlertController(title: "Alert", message: "Your cart must contain at least one dish.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        performSegue(withIdentifier: "goToOrder", sender: self)
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
                return nil
            }
        }

        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - Configure subviews
extension MenuViewController {
    func configureCartButton() {
        cartButton.setTitle("Cart: \(brain.getCurrentOrder().count) items", for: .normal)
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
        snapshot.appendItems(brain.getPromos(), toSection: .promo)
        snapshot.appendItems(brain.getCategories(), toSection: .category)
        
        let currentData = brain.getFoodData().filter { menuItem in
            menuItem.data.type == brain.selectedCategoryItem
        }
        
        snapshot.appendSections([.menu(foodType: brain.selectedCategoryItem)])
        snapshot.appendItems(currentData, toSection: .menu(foodType: brain.selectedCategoryItem))
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
            brain.selectedCategoryItem = (dataSource.snapshot(for: .category).items[indexPath.item] as! FoodCategoryModel).categoryName
            
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
            
            guard let cell = sender as? MenuCollectionViewCell, let cellData = cell.cellData else {
                fatalError("Cannot typecast to MenuCollectionViewCell")
            }
            
            vc.item = cellData
            vc.isAlreadyChosen = brain.checkIfOrderContains(itemID: cellData.id)
            vc.delegate = self
            
        } else if segue.identifier == "goToOrder" {
            guard let vc = segue.destination as? OrderViewController else {
                fatalError("Cannot typecast to OrderViewController")
            }
            
            vc.menuBrain = brain
        }
    }
}
//MARK: - Chosen dish
extension MenuViewController: DataSendingDelegate {
    func addToCart(itemID: String) {
        brain.addToCart(itemID: itemID)
        configureCartButton()
    }
}

//MARK: - MenuBrainDelegate

extension MenuViewController: MenuBrainDelegate {
    func updateData() {
        applySnapshot()
    }
    
    
}
