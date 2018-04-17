//
//  DonateViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 4/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit

class DonateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Donate"
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let alert = UIAlertController(title: "Unavailable", message: "These campaigns are for the purpose of a demo and donating money is disabled", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
