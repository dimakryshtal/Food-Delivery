//
//  OrderViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 21.01.2023.
//

import UIKit
import MapKit
import CoreLocation

protocol OrderDishCellDelegate: AnyObject {
    func removeCell(dish: OrderItemModel)
}

protocol UpdateMapViewDelegate {
    func updateMapView(locationCoordinate: CLLocationCoordinate2D)
    func updateLocationView(locationCoordinate: CLLocationCoordinate2D)
}


class OrderViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var locationView: UITextField!
    @IBOutlet weak var nameView: UITextField!
    
    weak var menuBrain: MenuBrain!
    
    var locationManager = CLLocationManager()
    var mapViewOpened = false
    
//    var mapViewDefaultConstraints: [NSLayoutConstraint]?
    var collectionViewHeightConstraint: NSLayoutConstraint? {
        didSet {
            if let oldValue {
                NSLayoutConstraint.deactivate([oldValue])
            }
            
            guard let collectionViewHeightConstraint else { return }
            NSLayoutConstraint.activate([collectionViewHeightConstraint])
        }
    }
    
    private lazy var dataSource = makeDataSource()
    
    deinit {
        print("OrderViewController deinitialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        locationManager.delegate = self
        
        collectionView.register(OrderDishCollectionViewCell.self, forCellWithReuseIdentifier: OrderDishCollectionViewCell.cellIdentifier)
        
        setLayout()
        applySnapshot()
        configureMapKit()
        configureTextFields()
        configureCollectionView()
        addGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
        
    }
    
    @IBAction func orderTapped(_ sender: Any) {
    }

}

//MARK: - Configure subviews

extension OrderViewController {
    
    func configureMapKit() {
        mapView.layer.cornerRadius = 30
        mapView.isScrollEnabled = false
        
//        mapViewDefaultConstraints = view.getConstraints(to: mapView) + mapView.constraints
    }
    
    func configureTextFields() {
        locationView.leftViewMode = .always
        nameView.leftViewMode = .always

        locationView.leftView = UIImageView.createImageViewForTextField(with: "location.fill")
        nameView.leftView = UIImageView.createImageViewForTextField(with: "person.fill")
        
        let firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
        
        nameView.text = "\(firstName == "" ? "" : firstName + " ")\(lastName)"
    }
    
    func configureCollectionView() {
        
        
        let collectionViewHeight = collectionView.frame.height
        let newHeight = CGFloat(110 * menuBrain.getCurrentOrder().count)
        
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: newHeight)
//                                                                                    newHeight > collectionViewHeight ? collectionViewHeight : newHeight)
    }
}

//MARK: - Gestures

extension OrderViewController {
    func addGestures() {
        let tapMapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMap))
        mapView.addGestureRecognizer(tapMapGesture)
        
        let tapLocationGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLocation))
        locationView.leftView?.addGestureRecognizer(tapLocationGesture)
    }
    
    @objc func didTapMap() {
        performSegue(withIdentifier: "presentMapView", sender: mapView)
    }
    
    @objc func didTapLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
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
                return nil
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
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
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
//
        dataSource.apply(snapshot)
    }
}

extension OrderViewController: OrderDishCellDelegate {
    func removeCell(dish: OrderItemModel) {
        menuBrain.removeFromCart(dish: dish)
        applySnapshot()
        configureCollectionView()
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - Segues

extension OrderViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentMapView" {
            guard let vc = segue.destination as? MapViewController else {
                fatalError("Could not typecast to MapViewController")
            }
            
            vc.delegate = self
        }
    }
}

//MARK: - Location Manager Delegate

extension OrderViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus == .authorizedWhenInUse else {
            return
        }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("called")
        if let location = locations.last {
            locationManager.stopUpdatingHeading()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat, lon)
            
            
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(languageCode: .english)) { places, _ in
                let place = places?.last
                self.locationView.text = place?.name
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension OrderViewController: UpdateMapViewDelegate {
    func updateMapView(locationCoordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = locationCoordinate
        let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(pin)
        
    }
    
    func updateLocationView(locationCoordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(languageCode: .english)) { places, _ in
            let place = places?.last
            self.locationView.text = place?.name
        }
    }
}
