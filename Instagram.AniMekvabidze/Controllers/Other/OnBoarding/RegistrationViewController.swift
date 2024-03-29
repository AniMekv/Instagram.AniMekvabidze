//
//  RegistrationViewController.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 5/29/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let userNameField: UITextField = {
        let field =  UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    
    private let emailField: UITextField = {
        let field =  UITextField()
        field.placeholder = "Email address"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self,
                                 action: #selector(onRegister),
                                 for: .touchUpInside)
        emailField.delegate = self
        userNameField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(emailField)
        view.addSubview(userNameField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        
        view.backgroundColor = .systemBackground

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userNameField.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top+100,
                                     width: view.width-40,
                                     height: 52)
        
        emailField.frame = CGRect(x: 20,
                                  y: userNameField.bottom+10,
                                  width: view.width-40,
                                     height: 52)
        passwordField.frame = CGRect(x: 20,
                                     y: emailField.bottom+10,
                                     width: view.width-40,
                                     height: 52)
        registerButton.frame = CGRect(x: 20,
                                     y: passwordField.bottom+10,
                                     width: view.width-40,
                                     height: 52)
    }
    
    @objc private func onRegister() {
        // dismiss the keyboard
        emailField.resignFirstResponder()
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let username = userNameField.text, !username.isEmpty else { return }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                    if registered {
                        //success
                    }
                    else{
                        // fail
                        
                    }
            }
        }
    }
    

}

extension RegistrationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        else {
            onRegister()
        }
        return true
    }
}
