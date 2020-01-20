//
//  ViewController.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    let serviceManager = ServiceManager()
    let urlStr = Constants.url
    var detailsArray: [Country] = []
}


extension ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        updateCountryDetails()
    }
    
    //Mark :Initialize UiTableView
    func initTableView() {
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.pinToSuperview()
    }
    
    //Mark:Update country details by calling API
    func updateCountryDetails(){
        serviceManager.getCountryDetails(url: urlStr) { [weak self] results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let result = results {
                self?.navigationItem.title = result.title
                self?.detailsArray = result.rows.compactMap { $0 }
                self?.tableView.reloadData()
                self?.tableView.setContentOffset(CGPoint.zero, animated: false)
            }
            
            if !errorMessage.isEmpty {
                print("Search error: " + errorMessage)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CustomTableViewCell.self, for: indexPath)
        
//        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: TrackCell.identifier,
//                                                            for: indexPath) as! CustomTableViewCell
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        let country = detailsArray[indexPath.row]
        cell.descriptionLabel.text = country.description
        cell.titleLable.text = country.title
        
        DispatchQueue.global(qos: .background).async {
            if let urlStr = country.imageRef{
                let url = URL(string:urlStr)
                let data = try? Data(contentsOf: url!)
                if let imageData = data{
                    let image = UIImage(data:imageData)
                    DispatchQueue.main.async {
                        cell.cellImageView.image = image
                    }
                }else{
                    DispatchQueue.main.async {
                        cell.cellImageView.image = #imageLiteral(resourceName: "flag_of_canada.png")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    cell.cellImageView.image = #imageLiteral(resourceName: "flag_of_canada.png")
                }
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
