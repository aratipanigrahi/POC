//
//  ServiceCore.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 22/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import Foundation
import Alamofire

class ServiceCore{
    
    typealias QueryResult = (CountryDetails?, String?) -> Void
    typealias JSONDictionary = [String: Any]
    var countryDetails = CountryDetails(title:"", rows: [])
    var errorMessage:String?
    
    
    
    /**
     * Description :Prepare the request and  sends a request to service core.
     * Parse and Updates the response with CountryDetails
     */
    
    open func getCountryDetails(url: String,completion: @escaping QueryResult) {
        guard let url = URL(string: url) else {
            completion(nil,"Url error")
            return
        }
        Alamofire.request(url,
                          method: .get,
                          parameters: nil)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching")
                    completion(nil,"Error while fetching")
                    return
                }
                
                self.updateResults(response.data!)
                DispatchQueue.main.async {
                    completion(self.countryDetails, self.errorMessage )
                }
        }
    }//End
    
    
    //Mark :Helper for parsing the Json Data
    private func updateResults(_ data: Data)  {
        
        var country = Country()
        var countryArray: [Country] = []
        var response: JSONDictionary?
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage = parseError.localizedDescription
            
            return
        }
        guard let countryTitle = response!["title"] as? String else {
            errorMessage = "Dictionary does not contain results key"
            return
        }
        guard let detailArray = response!["rows"] as? [Any] else {
            errorMessage = "Dictionary does not contain results key"
            return
        }
        
        for item in detailArray {
            if let item = item as? JSONDictionary,
                let title = item["title"] as? String,
                let img  = item["imageHref"] as? String,
                let desc = item["description"] as? String 
            {
                country = Country(title: title, description: desc, imageRef: img)
                countryArray.append(country)
            }
        }
        
        countryDetails = CountryDetails(title: countryTitle, rows: countryArray)
    }
    
}
