//
//  ViewCampaignViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class ViewCampaignViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var campaign: Campaign?
    var secondCellHeight: CGFloat = 0
    
    @IBAction func contributeButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
    }
}

extension ViewCampaignViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "campaignUserCell", for: indexPath) as! CampaignUserCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.fullNameLabel.text = "Full Name"
            //            cell.profileImage.loadImageFromUrlString(urlString: )
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "campaignDescriptionCell", for: indexPath) as! CampaignDescriptionCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.descriptionTextField.text = self.campaign?.description
            cell.descriptionTextField.sizeToFit()
            cell.descriptionTextField.isScrollEnabled = false
            
            cell.titleLabel.text = self.campaign?.title
            
            self.secondCellHeight = cell.descriptionTextField.contentSize.height + cell.titleLabel.intrinsicContentSize.height + 10
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 156
        } else {
            return self.secondCellHeight
        }
    }

}
