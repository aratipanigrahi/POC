//
//  CountryDisplaybleViewModel.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 22/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import Foundation

// MARK: - Delegate
public protocol CountryDelegate: class {
    func updateCountryDetail(update item: CountryDetails)
    func updateCountryDetail(didFail error: String)
}


//Mark:ViewModelClass
class CountryDisplaybleViewModel{
    
    var delegate: CountryDelegate?
    var countrySummary: CountryDetails? {
        didSet {
            self.didUpdate?()
        }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    // MARK: - Closures for callback
    var didUpdate:(() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var serviceManager = ServiceManager()
    
    init() {
        serviceManager.delegate = self
    }
    
    //Fetch Country details with the given url
    func fetchCountryDetails(urlStr:String) {
        if !urlStr.isEmpty{
            self.isLoading = true
            serviceManager.updateCountryDetails(url:urlStr)
        }
    }
}


//Mark : CountryDelegate
extension CountryDisplaybleViewModel:CountryDelegate{
    func updateCountryDetail(didFail error: String) {
        print("CountryDetail Fetch Error: \(error)")
        self.isLoading = false
    }
    
    func updateCountryDetail(update item: CountryDetails){
        self.isLoading = false
        self.countrySummary = item
    }
}
