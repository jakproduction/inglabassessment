//
//  ViewController.swift
//  inglab_assessment
//
//  Created by Chia Chi on 19/04/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "app_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Inglab Assessment"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    let usernameUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2.0
        
        return view
    }()
    
    let usernameTextField: UITextField = {
        let imageView = UIImageView()
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.borderStyle = .none
        return textField
    }()
    
    let usernameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_user")
        imageView.contentMode = .center
        return imageView
    }()
    
    let passwordUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2.0
        
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.borderStyle = .none
      
        return textField
    }()
    
    let passwordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_password")
        imageView.contentMode = .center
        return imageView
    }()
    
    let toggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_eye_close"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.addTarget(self, action: #selector(password_toggle_Clicked), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(login_Clicked), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let backgroundImage = UIImage(named: "background")
        view.backgroundColor = UIColor(patternImage: backgroundImage!)
        
        configureSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    func configureSubviews(){
        
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(loginButton)
        view.addSubview(usernameUIView)
        view.addSubview(passwordUIView)
        
        usernameUIView.addSubview(usernameTextField)
        usernameUIView.addSubview(usernameIcon)
        
        passwordUIView.addSubview(passwordTextField)
        passwordUIView.addSubview(passwordIcon)
        passwordUIView.addSubview(toggleButton)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameUIView.translatesAutoresizingMaskIntoConstraints = false
        usernameIcon.translatesAutoresizingMaskIntoConstraints = false
        passwordUIView.translatesAutoresizingMaskIntoConstraints = false
        passwordIcon.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150 ),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            usernameUIView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            usernameUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameUIView.heightAnchor.constraint(equalToConstant: 50),
            
            usernameIcon.leadingAnchor.constraint(equalTo: usernameUIView.leadingAnchor, constant: 10),
            usernameIcon.centerYAnchor.constraint(equalTo: usernameUIView.centerYAnchor),
            usernameIcon.widthAnchor.constraint(equalToConstant: 20),
            usernameIcon.heightAnchor.constraint(equalToConstant: 20),
            
            usernameTextField.leadingAnchor.constraint(equalTo: usernameIcon.trailingAnchor, constant: 10),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameUIView.trailingAnchor, constant: -10),
            usernameTextField.centerYAnchor.constraint(equalTo: usernameUIView.centerYAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            passwordUIView.topAnchor.constraint(equalTo: usernameUIView.bottomAnchor, constant: 20),
            passwordUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordUIView.heightAnchor.constraint(equalToConstant: 50),
            
            passwordIcon.leadingAnchor.constraint(equalTo: passwordUIView.leadingAnchor, constant: 10),
            passwordIcon.centerYAnchor.constraint(equalTo: passwordUIView.centerYAnchor),
            passwordIcon.widthAnchor.constraint(equalToConstant: 20),
            passwordIcon.heightAnchor.constraint(equalToConstant: 20),
            
            toggleButton.trailingAnchor.constraint(equalTo: passwordUIView.trailingAnchor, constant: -10),
            toggleButton.centerYAnchor.constraint(equalTo: passwordUIView.centerYAnchor),
            toggleButton.widthAnchor.constraint(equalToConstant: 20),
            toggleButton.heightAnchor.constraint(equalToConstant: 20),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordIcon.trailingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: toggleButton.leadingAnchor, constant: 10),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordUIView.centerYAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            
            loginButton.topAnchor.constraint(greaterThanOrEqualTo:  passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    //MARK: onClick Function
    @objc func password_toggle_Clicked(sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setImage(UIImage(named: "icon_eye_open"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "icon_eye_close"), for: .normal)
        }
    }
    
    @objc func login_Clicked(sender: UIButton) {
        let listingVC = ListingVC()
        let navController = UINavigationController(rootViewController: listingVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    @objc func close_keyboard_Clicked() {
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
}
