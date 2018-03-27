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
    
    @IBAction func addCampaignButton(_ sender: Any) {
//        Segue to createCampaignVC
        performSegue(withIdentifier: "createCampaignSegue", sender: sender)
    }
    
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = generateRandomData()
        
//        self.tableView.register(CampaignCVCell.self, forCellReuseIdentifier: "campaignCVCell")
        
        self.tableView.allowsSelection = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
//       Set up tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "featuredCampaignCell", for: indexPath) as! FeaturedCampaignCell
            cell.categoryLabel.text = "Campaign of the day"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "campaignsTVCell", for: indexPath) as! CampaignsTVCell
            cell.categoryLabel.text = "Trending this week"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? CampaignsTVCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? CampaignsTVCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 301
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
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

