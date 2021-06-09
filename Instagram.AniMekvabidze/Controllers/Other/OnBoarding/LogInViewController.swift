//
//  LogInViewController.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 5/29/21.
//

// to open webView
import SafariServices
import UIKit
//import FirebaseAuth


class LogInViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }

    private let userNameEmailField: UITextField = {
        let field =  UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
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
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button    }()

    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "Gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(onLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(onCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(onTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(onPrivacyButton), for: .touchUpInside)

        userNameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground

    }
    
    override func viewDidLayoutSubviews() {
        //assign frames

        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3)
        
        userNameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52.0)
        
        passwordField.frame = CGRect(
            x: 25,
            y: userNameEmailField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        termsButton.frame = CGRect(x: 10,
                                   y: view.height-view.safeAreaInsets.bottom-100,
                                   width: view.width-20,
                                   height: 50)
        privacyButton.frame = CGRect(x: 10,
                                   y: view.height-view.safeAreaInsets.bottom-50,
                                   width: view.width-20,
                                   height: 50)
        configureHeaderView()

    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        // add insta logo
        let imageView = UIImageView(image: UIImage(named: "logoo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4, y: additionalSafeAreaInsets.top, width: headerView.width/2, height: headerView.height - view.safeAreaInsets.top)
        
        
    }

    
    private func addSubviews() {
       // viewDidLayoutSubviews()
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
       // view.addSubview(userNameEmailField)

    }
    
    @objc private func onLoginButton() {
        // to dismiss keyboard
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let usernameEmail = userNameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else { return }
        
        
        // login functionality
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            //email
            email = usernameEmail
        }
        else {
            // username
            username = usernameEmail
        }

        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
            
            if success {
                // user loged in
                self.dismiss(animated: true, completion: nil)
            }
            else {
                //error
                let alert = UIAlertController(title: "Log In Error", message: "We were unavailable to log you in", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            }
        }
      }
    }
    
    
    @objc private func onTermsButton() {
        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func onPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func onCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        
        present(UINavigationController(rootViewController: vc), animated: true)
       //present(vc, animated: true)
        
    }



}

extension LogInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            onLoginButton()
        }
        
        return true
    }
}
