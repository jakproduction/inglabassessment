//
//  UserListingCell.swift
//  inglab_assessment
//
//  Created by Chia Chi on 20/04/2023.
//
import UIKit

class UserListingCell: UITableViewCell {
    let userImageView = UIImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }()
    
    let contactLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.numberOfLines = 0
        
        return label
    }()
    
    let bottomLineView = UIView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        
        contentView.addSubview(userImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contactLabel)
        contentView.addSubview(bottomLineView)
        userImageView.addSubview(activityIndicator)
    }
    
    private func configureConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView.backgroundColor = UIColor.gray
        
        NSLayoutConstraint.activate([
            
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), userImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 5), userImageView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -5), userImageView.heightAnchor.constraint(equalToConstant: 80), userImageView.widthAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            
            contactLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20),
            contactLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contactLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            //contactLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomLineView.topAnchor, constant: -5),
            
            
            bottomLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            bottomLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 20),
            bottomLineView.topAnchor.constraint(greaterThanOrEqualTo: contactLabel.bottomAnchor, constant: 5),
            bottomLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
