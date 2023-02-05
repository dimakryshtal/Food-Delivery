//
//  SignUpViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 04.02.2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTextFields()
    }
    
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

//MARK: - Configure views

extension SignUpViewController {
    func configureTextFields() {
        firstNameTextField.leftViewMode = .always
        lastNameTextField.leftViewMode = .always
        emailTextField.leftViewMode = .always
        passwordTextField.leftViewMode = .always
        
        emailTextField.leftView = UIImageView.createImageViewForTextField(with: "envelope")
        passwordTextField.leftView = UIImageView.createImageViewForTextField(with: "lock")
    }
}
