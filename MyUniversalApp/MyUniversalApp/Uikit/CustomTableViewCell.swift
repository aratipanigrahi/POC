//
//  CustomTableViewCell.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CustomTableViewCell.self)
    
    
    let titleLable = UILabel()
    
    let stackView = UIStackView()
    var cellImageView = UIImageView()
    var descriptionLabel = UILabel()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Todo :set titleLable property
        contentView.addSubview(titleLable)
        
        //Todo :set stackView property
        contentView.addSubview(stackView)
        
        
        //Todo :set cellImageView property
        
        stackView.addArrangedSubview(cellImageView)
        
        
        //Todo :set descriptionLabel property
        stackView.addArrangedSubview(descriptionLabel)
        
        titleLable.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
