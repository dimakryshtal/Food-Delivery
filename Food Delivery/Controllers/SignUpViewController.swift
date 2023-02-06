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

    override func viewWillAppear(_ animated: Bool) {
        firstNameTextField.text = "test"
        lastNameTextField.text = "test"
        emailTextField.text = "test@gmail.com"
        passwordTextField.text = "123456"
    }
    
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let authResult, error == nil else {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if let firstName = self?.firstNameTextField.text, let lastName = self?.lastNameTextField.text {
                UserDefaults.standard.set(firstName, forKey: "firstName")
                UserDefaults.standard.set(lastName, forKey: "lastName")
                FirestoreManager.shared.createUserInDB(userID: authResult.user.uid, firstName: firstName, lastName: lastName)
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
