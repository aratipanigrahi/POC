//
//  ViewController.swift
//  MyUniversalApp
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy private var tableView = UITableView()
    lazy var detailsArray: [Country] = []
    lazy var displayble : CountryDisplaybleViewModel = {
        let displayble = CountryDisplaybleViewModel()
        return displayble
    }()
    var activityIndicator = UIActivityIndicatorView(style: .gray)
}


extension ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = CGFloat(UIConstants.estimatedRowHeight)
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.pinToSuperview()
        
        self.fetchCountryDetails()
        self.addActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //Activity indicator
    func addActivityIndicator(){
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
    }
    
    
    //MarK:Networking fetchCountryDetails
    private func fetchCountryDetails(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        displayble.fetchCountryDetails(urlStr: Constants.url)
        
        displayble.updateLoadingStatus = {
            let _ = self.displayble.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        displayble.didUpdate = {
            self.didUpdate()
        }
    }
    
    //Mark :Update the UI
    private func didUpdate() {
        self.navigationItem.title = self.displayble.countrySummary!.title
        self.detailsArray = self.displayble.countrySummary!.rows
        self.tableView.reloadData()
      //  self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        print("start")
    }
    
    private func activityIndicatorStop() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        print("stop")
    }
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CustomTableViewCell.self, for: indexPath)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        let country = detailsArray[indexPath.row]
        cell.descriptionLabel.text = country.description
        cell.titleLable.text = country.title
        // self.activityIndicatorStart()
        DispatchQueue.global(qos: .background).async {
            if let urlStr = country.imageRef{
                let url = URL(string:urlStr)
                let data = try? Data(contentsOf: url!)
                if let imageData = data{
                    let image = UIImage(data:imageData)
                    DispatchQueue.main.async {
                        cell.cellImageView.image = image
                        //  self.activityIndicatorStop()
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
    
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
