//
//  DetailsVC.swift
//  inglab_assessment
//
//  Created by Chia Chi on 20/04/2023.
//

import UIKit
import AlamofireImage

class DetailsVC: UIViewController {
    
    var data:User?
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageView.image = UIImage(named: "user_image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let contactView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contactIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon_call")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let contactLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon_email")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Descriptions"
        label.textColor = .gray
        label.textAlignment = .left

        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "background")
        view.backgroundColor = UIColor(patternImage: backgroundImage!)
        
        setupToolBar()
        configureSubviews()
        setupData()
    }
    
    func setupData(){
        contactLabel.text = data?.phone
        emailLabel.text = data?.email
    }
    
    func setupToolBar(){
        navigationItem.title = data?.name
        navigationItem.titleView?.tintColor = .black
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "icon_back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Create a UIBarButtonItem with the custom button as its custom view
        let backButtonItem = UIBarButtonItem(customView: backButton)

        // Set the back button as the leftBarButtonItem of the navigationItem
        navigationItem.leftBarButtonItem = backButtonItem
        
    }
    
    private func configureSubviews() {

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
       
        
        contentView.addSubview(userImageView)
        contentView.addSubview(contactView)
        contentView.addSubview(emailView)
        contentView.addSubview(descriptionView)
        
        
        contactView.addSubview(contactIconImageView)
        contactView.addSubview(contactLabel)
        
        emailView.addSubview(emailLabel)
        emailView.addSubview(emailIconImageView)
        
        descriptionView.addSubview(descriptionLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // User image view constraints
        NSLayoutConstraint.activate([
            
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 150),
            userImageView.widthAnchor.constraint(equalToConstant: 150),
            
            contactView.topAnchor.constraint(equalTo: userImageView.bottomAnchor,constant: 20),
            contactView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contactView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contactView.heightAnchor.constraint(equalToConstant: 70),
            
            contactIconImageView.leadingAnchor.constraint(equalTo: contactView.leadingAnchor, constant: 10),
            contactIconImageView.centerYAnchor.constraint(equalTo: contactView.centerYAnchor),
            contactIconImageView.widthAnchor.constraint(equalToConstant: 30),
            contactIconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            contactLabel.centerXAnchor.constraint(equalTo: contactView.centerXAnchor),
            contactLabel.centerYAnchor.constraint(equalTo: contactView.centerYAnchor),
            contactLabel.leadingAnchor.constraint(equalTo: contactIconImageView.leadingAnchor, constant: 60),
            contactLabel.trailingAnchor.constraint(equalTo: contactView.trailingAnchor, constant: -20),
            
            emailView.topAnchor.constraint(equalTo: contactView.bottomAnchor,constant: 20),
            emailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            emailView.heightAnchor.constraint(equalToConstant: 70),
            
            emailIconImageView.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 10),
            emailIconImageView.centerYAnchor.constraint(equalTo: emailView.centerYAnchor),
            emailIconImageView.widthAnchor.constraint(equalToConstant: 30),
            emailIconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            emailLabel.centerXAnchor.constraint(equalTo: emailView.centerXAnchor),
            emailLabel.centerYAnchor.constraint(equalTo: emailView.centerYAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: emailIconImageView.leadingAnchor, constant: 60),
            emailLabel.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -20),
            
            descriptionView.topAnchor.constraint(equalTo: emailView.bottomAnchor,constant: 20),
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            descriptionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor,constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo:  descriptionView.bottomAnchor,constant: 5)
            
        ])
        
        let url = URL(string: (data?.avatar!)!)
        userImageView.af_setImage(withURL: url!)
    }
    
    @objc func backButtonTapped() {
        // Handle back button tap here
        navigationController?.popViewController(animated: true)
    }
}
