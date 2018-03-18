//
//  LoginViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet var nameTextCheck: UITextField!
    @IBOutlet var passwordTextCheck: UITextField!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "campaignsSegue", sender: sender)
    }
    

    /////////////////////////////////////////////////////////////////////////
    //
    // Guardar Usuarios
    
    

    /////////////////////////////////////////////////////////////////////////
    //
    // Crear Usuarios
    @IBAction func newUser(_ sender: Any) {
        let alert = UIAlertController(title: nil , message: nil ,preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "UserName"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Nickname"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        let actionSave = UIAlertAction(title: "Save", style: .default) { (action) in print("Saving all users")
            /////////////////////////////////////////////////////
            // How do I save the users
        
            
        }
    }
    
    
    /////////////////////////////////////////////////////////////////////////
    //
    // Creas tu usuario, se guarda y con este ingresas
    
}
