//
//  campaignUserCell.swift
//  fj-mobile
//
//  Created by Tony Cioara on 4/5/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class CampaignUserCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    //    This is not for the user. It is for the campaign :>
    @IBOutlet weak var progressLabel: UILabel!
}
