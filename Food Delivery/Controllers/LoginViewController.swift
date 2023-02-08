//
//  LoginViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 04.02.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        configureTextFields()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {

        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) {authresult, error in
            if let err = error {
                let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

//MARK: - Configure views

extension LoginViewController {
    func configureTextFields() {
        emailTextField.leftViewMode = .always
        passwordTextField.leftViewMode = .always
        
        emailTextField.leftView = UIImageView.createImageViewForTextField(with: "envelope")
        passwordTextField.leftView = UIImageView.createImageViewForTextField(with: "lock")
        
    }
}



//MARK: - TextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
