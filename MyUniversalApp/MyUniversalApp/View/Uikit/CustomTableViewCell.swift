//
//  CustomTableViewCell.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //
    // MARK: - Class Constants
    //
    
    static let reuseIdentifier = String(describing: CustomTableViewCell.self)
    
    let titleLable = UILabel()
    
    let stackView = UIStackView()
    var cellImageView = UIImageView()
    var descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Todo :set titleLable property
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.textColor = .brown
        titleLable.textAlignment = .left
        contentView.addSubview(titleLable)
        
        //Todo :set stackView property
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12.0
        contentView.addSubview(stackView)
        
        
        //Todo :set cellImageView property
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFit
        cellImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.addArrangedSubview(cellImageView)
        
        
        //Todo :set descriptionLabel property
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .blue
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        stackView.addArrangedSubview(descriptionLabel)
        
        titleLable.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        NSLayoutConstraint(item: cellImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: stackView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: cellImageView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: stackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 20.0).isActive = true
        
        cellImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        cellImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
