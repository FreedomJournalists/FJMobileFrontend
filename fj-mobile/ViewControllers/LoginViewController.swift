//
//  LoginViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import SpriteKit

class LoginViewController: UIViewController {
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "campaignsSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
