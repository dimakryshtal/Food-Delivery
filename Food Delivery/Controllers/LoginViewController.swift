//
//  LoginViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 04.02.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "mainController") as! UINavigationController
        guard let menuViewController = navController.topViewController as? MenuViewController else { fatalError("Could not typecast to ManuViewController") }
        menuViewController.brain = MenuBrain()
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve

        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.3

        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)

    }

    @IBAction func signinButtonTapped(_ sender: Any) {
    }
}
