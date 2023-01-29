//
//  OrderViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 21.01.2023.
//

import UIKit

protocol OrderDishCellDelegate {
    func removeCell(dish: OrderItemModel)
}


class OrderViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var menuBrain: MenuBrain!
    private lazy var dataSource = makeDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(menuBrain.getCurrentOrder())

        collectionView.register(OrderDishCollectionViewCell.self, forCellWithReuseIdentifier: OrderDishCollectionViewCell.cellIdentifier)
        
        
        setLayout()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func orderTapped(_ sender: Any) {
    }

}

//MARK: - Layout

extension OrderViewController {
    private func setLayout() {
        let layout = UICollectionViewCompositionalLayout { section, environment in
            switch section {
            case 0:
                return OrderViewLayout.shared.chosenDishes()
            default:
                return OrderViewLayout.shared.chosenDishes()
            }
            
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}


//MARK: - DataSource and Snapshot

extension OrderViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<OrderViewLayout.Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<OrderViewLayout.Section, AnyHashable>

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            if let order = item as? OrderItemModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderDishCollectionViewCell.cellIdentifier,
                                                              for: indexPath) as? OrderDishCollectionViewCell
                cell?.orderData = order
                cell?.delegate = self
                cell?.indexPath = indexPath
                return cell
            }
            return nil
        }
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        
        
        
        var snapshot = Snapshot()
        
        snapshot.appendSections([.chosenDishes])

        snapshot.appendItems(Array(menuBrain.getCurrentOrder()), toSection: .chosenDishes)
        
        
        dataSource.apply(snapshot)
       
    }
}

extension OrderViewController: OrderDishCellDelegate {
    func removeCell(dish: OrderItemModel) {
        menuBrain.removeFromCart(dish: dish)
        print(menuBrain.getCurrentOrder())
        applySnapshot()
        
    }
}
