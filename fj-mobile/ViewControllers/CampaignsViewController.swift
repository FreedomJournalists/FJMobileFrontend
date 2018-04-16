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
    var campaigns: [Campaign] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addCampaignButton(_ sender: Any) {
//        Segue to createCampaignVC
        performSegue(withIdentifier: "createCampaignSegue", sender: sender)
    }
    @IBAction func profileButton(_ sender: Any) {
        performSegue(withIdentifier: "profileSegue", sender: sender)
    }
    
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = generateRandomData()
        
//        Navigation bar setup
        navigationController?.navigationBar.barTintColor = UIColor(red:0.85, green:0.68, blue:0.51, alpha:1.0)
        navigationController?.navigationBar.tintColor = UIColor.black
        
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.loadCampaigns {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
//        self.tableView.allowsSelection = false
        
    }
    
//       Set up tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "featuredCampaignCell", for: indexPath) as! FeaturedCampaignCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            let currentCampaign = self.campaigns[0]
            
            cell.categoryLabel.text = "Campaign of the day"
            
            cell.darkView.layer.cornerRadius = 5
            
            cell.customImageView.contentMode = .scaleAspectFill
            cell.customImageView.layer.cornerRadius = 5
            cell.customImageView.clipsToBounds = true
            
            let imageUrl = currentCampaign.image_file_url
            cell.customImageView.loadImageFromUrlString(urlString: imageUrl)
            cell.campaignTitle.text = currentCampaign.title
            cell.campaignTitle.sizeToFit()
            
            cell.progressLabel.text = String(Int(currentCampaign.money_raised)) + " / " + String(currentCampaign.goal)
            cell.progressLabel.sizeToFit()
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "campaignsTVCell", for: indexPath) as! CampaignsTVCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.categoryLabel.text = "Trending this week"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let currentCampaign = self.campaigns[0]
            self.segueToViewCampaign(selectedCampaign: currentCampaign)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model.count
        if self.campaigns.count == 0 {
            return 0
        }
        return 2
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


extension CampaignsViewController {
    func loadCampaigns(completion: @escaping ()->()) {
        Network.instance.fetch(route: .getAllCampaigns) { (data, resp) in
            print(resp)
            let jsonCampaigns = try? JSONDecoder().decode([Campaign].self, from: data)
            if let campaigns = jsonCampaigns {
                self.campaigns = campaigns
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                completion()
            }
        }
    }
}

extension CampaignsViewController {
    func segueToViewCampaign(selectedCampaign: Campaign) {
        let storyboard = UIStoryboard(name: "ViewCampaignVC", bundle: Bundle.main)
        let viewCampaignVC = storyboard.instantiateInitialViewController() as! ViewCampaignViewController
        
//        let viewCampaignVC = storyboard?.instantiateViewController(withIdentifier: "ViewCampaignVC") as! ViewCampaignViewController
        viewCampaignVC.campaign = selectedCampaign
        navigationController?.pushViewController(viewCampaignVC, animated: true)
    }
}

extension CampaignsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return model[collectionView.tag].count
        return (campaigns.count) - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "campaignCVCell", for: indexPath) as! CampaignCVCell
        
//        cell.backgroundColor = model[collectionView.tag][indexPath.item]
        
        let currentCampaign = self.campaigns[indexPath.row + 1]
        
        cell.titleLabel.text = currentCampaign.title
        cell.titleLabel.sizeToFit()
        
        cell.progressLabel.text = String(Int(currentCampaign.money_raised)) + " / " + String(currentCampaign.goal)
        cell.progressLabel.sizeToFit()
        
        cell.darkView.layer.cornerRadius = 5
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.layer.cornerRadius = 5
        cell.imageView.clipsToBounds = true
        
        let imageUrl = currentCampaign.image_file_url
        
        cell.imageView.loadImageFromUrlString(urlString: imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCampaign = self.campaigns[indexPath.row + 1]
        self.segueToViewCampaign(selectedCampaign: currentCampaign)
        
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

