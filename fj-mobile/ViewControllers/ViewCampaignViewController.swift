//
//  ViewCampaignViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class ViewCampaignViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var customImageView: CustomImageView!
    
    var campaign: Campaign?
    
    @IBAction func contributeButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextField.text = campaign!.description
        
    }
    
}
