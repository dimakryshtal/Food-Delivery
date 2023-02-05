//
//  HelperFunctions.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 05.02.2023.
//

import UIKit

class HelperFunctions {
    static let shared = HelperFunctions()
}

extension HelperFunctions {
//    func getMenuView() -> UINavigationController {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let navController = mainStoryboard.instantiateViewController(withIdentifier: "mainController") as? UINavigationController else {
//            fatalError("Could not typecast to UINavigationController")
//        }
//        guard let menuViewController = navController.topViewController as? MenuViewController else { fatalError("Could not typecast to ManuViewController") }
//        menuViewController.brain = MenuBrain()
//        return navController
//    }
//    
//    func setNewRootController(view: UIView, newRootView: UIViewController) {
//        guard let window = view.window?.windowScene?.keyWindow else { return }
//        
//        window.rootViewController = newRootView
//        window.makeKeyAndVisible()
//        
//        let options: UIView.AnimationOptions = .transitionCrossDissolve
//
//        // The duration of the transition animation, measured in seconds.
//        let duration: TimeInterval = 0.3
//
//        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
//    }
}
