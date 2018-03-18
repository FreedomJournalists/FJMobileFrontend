//
//  CampaignsViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class CampaignsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//        Only for testing
    var model: [[UIColor]]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = generateRandomData()
        
//        self.tableView.register(CampaignCVCell.self, forCellReuseIdentifier: "campaignCVCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
//       Set up tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "campaignsTVCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? CampaignsTVCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    
//        Only for testing
    func generateRandomData() -> [[UIColor]] {
        let numberOfRows = 20
        let numberOfItemsPerRow = 15
        
        return (0..<numberOfRows).map { _ in
            return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
        }
    }
}

extension CampaignsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "campaignCVCell", for: indexPath)
        
        cell.backgroundColor = model[collectionView.tag][indexPath.item]
        
        return cell
    }
}

extension UIColor {
    
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}

