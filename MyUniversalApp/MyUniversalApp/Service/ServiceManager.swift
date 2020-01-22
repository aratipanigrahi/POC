//
//  ServiceManager.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import Foundation

import SwiftyJSON

class ServiceManager {
    
    open var delegate: CountryDelegate?
    var errorMessage = ""
    let serviceCore = ServiceCore()
    
    
    /**
     Description:Will fetch the CountryDetails asynchronously .
     If an error occurs, the delegate's updateCountryDetail(didFail:e) will be called
     Otherwise, the delegate's updateCountryDetail(update: details!) will be called
     */
    
    func updateCountryDetails(url: String){
        serviceCore.getCountryDetails(url: url) { [weak self] results, errorMessage in
            if let s = self {
                let country = CountryDetails(title: (results?.title)!, rows: (results?.rows)!)
                s.delegate?.updateCountryDetail(update: country)
            }
        }
    }
    
    // MARK: Helpers for retriveCountryDetails
    func didRetrieveData(details: CountryDetails?, with error: String?) {
        
        if let e = error {
            self.delegate?.updateCountryDetail(didFail:e)
        } else {
            self.delegate?.updateCountryDetail(update: details!)
        }
        
    }
}
