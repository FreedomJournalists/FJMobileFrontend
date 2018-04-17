//
//  campaignUserCell.swift
//  fj-mobile
//
//  Created by Tony Cioara on 4/5/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

protocol CampaignUserCellDelegate {
    func twitterButtonClicked(cell: CampaignUserCell)
    func facebookButtonClicked(cell: CampaignUserCell)
    func instagramButtonClicked(cell: CampaignUserCell)
}

class CampaignUserCell: UITableViewCell {
    
    var delegate: CampaignUserCellDelegate? = nil
    
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    //    This is not for the user. It is for the campaign :>
    @IBOutlet weak var progressLabel: UILabel!
    @IBAction func instagramButton(_ sender: Any) {
        print("point1")
        delegate?.instagramButtonClicked(cell: self)
    }
    @IBAction func facebookButton(_ sender: Any) {
        print("point1")
        delegate?.facebookButtonClicked(cell: self)
    }
    @IBAction func twitterButton(_ sender: Any) {
        print("point1")
        delegate?.twitterButtonClicked(cell: self)
    }
}
