//
//  ProfileInfoCell.swift
//  fj-mobile
//
//  Created by Tony Cioara on 4/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

protocol UserProfileDelegate {
    func didClickSelectButton(cell: ProfileInfoCell)
    func didClickLogOut(cell: ProfileInfoCell)
}

class ProfileInfoCell: UITableViewCell {
    
    var delegate: UserProfileDelegate? = nil
    
    @IBOutlet weak var profileImageView: CustomImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func selectImageButton(_ sender: Any) {
        delegate?.didClickSelectButton(cell: self)
    }
    @IBAction func logOutButton(_ sender: Any) {
        delegate?.didClickLogOut(cell: self)
    }
    
}
