//
//  CountryModel.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import Foundation

//Mark:Country Model
struct Country: Equatable {
    
    internal(set) var title:String?
    internal(set) var description:String?
    internal(set) var imageRef :String?
    
    init() {}
    
    public init(title: String, description: String, imageRef: String) {
        self.title = title
        self.description = description
        self.imageRef = imageRef
    }
}


//
// MARK: - CountryDetails Model
//
public class CountryDetails {
    
    let title: String
    var rows:[Country] = []
    
    //
    // MARK: - Initialization
    //
    init(title: String, rows:[Country]) {
        self.title = title
        self.rows = rows
    }
}
