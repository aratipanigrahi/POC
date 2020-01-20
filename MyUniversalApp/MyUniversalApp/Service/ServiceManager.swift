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
    
    let defaultSession = URLSession(configuration: .default)
    
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    //
    // MARK: - Type Alias
    //
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = (CountryDetails?, String) -> Void
    
    var countryDetails = CountryDetails(title:"", rows: [])
    
    //
    // MARK: - Internal Methods
    //
    
    func getCountryDetails(url: String, completion: @escaping QueryResult) {
        // 1
        dataTask?.cancel()
        
        // 2
        if var urlComponents = URLComponents(string: url) {
            
            guard let urlStr = urlComponents.url else {
                return
            }
            
            // 4
            dataTask = defaultSession.dataTask(with: urlStr) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                
                // 5
                if let error = error {
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    self?.updateResults(data)
                    
                    // 6
                    DispatchQueue.main.async {
                        completion(self?.countryDetails, self?.errorMessage ?? "")
                    }
                }
            }
            
            // 7
            dataTask?.resume()
        }
    }
    
    //
    // MARK: - Private Methods
    //
    private func updateResults(_ data: Data)  {
        
        var country = Country()
        var countryArray: [Country] = []
        
        
        //Using SwiftJSOn
        /*  var response:JSON = JSON.null
         do {
         response = try JSON(data: data)
         //response = json
         } catch let parseError as NSError {
         errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
         return Track(title: "", rows: [])
         }
         
         
         
         guard let countryTitle = response["title"].string else {
         errorMessage += "Dictionary does not contain results key\n"
         return Track(title: "", rows: [])
         }
         
         guard let rowsArray = response["rows"].array else {
         errorMessage += "Dictionary does not contain results key\n"
         return Track(title: "", rows: [])
         }
         
         for item in rowsArray {
         print(item["title"].stringValue)
         print(item["imageHref"].stringValue)
         print(item["description"].stringValue)
         
         let title = item["title"].stringValue
         let img  = item["imageHref"].stringValue
         let desc = item["description"].stringValue
         
         country = Country(title: title, description: desc, imageRef: img)
         countryArray.append(country)
         
         }*/
        
        
        
        var response: JSONDictionary?
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        guard let countryTitle = response!["title"] as? String else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        guard let detailArray = response!["rows"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        
        for trackDictionary in detailArray {
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let title = trackDictionary["title"] as? String,
                let img  = trackDictionary["imageHref"] as? String,
                let desc = trackDictionary["description"] as? String
            {
                country = Country(title: title, description: desc, imageRef: img)
                countryArray.append(country)
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
        
        countryDetails = CountryDetails(title: countryTitle, rows: countryArray)
    }
}
