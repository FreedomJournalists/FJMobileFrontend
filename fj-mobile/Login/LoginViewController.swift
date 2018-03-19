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
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let searchString = self.nameTextCheck.text
        let searchString2 = self.passwordTextCheck.text
        request.predicate = NSPredicate (format: "name == %@", searchString!)
        do
        {
            let result = try context.fetch(request)
            if result.count > 0
            {
                let n = (result[0] as AnyObject).value(forKey: "name") as! String
                let p = (result[0] as AnyObject).value(forKey: "password") as! String
                
                if (searchString == n && searchString2 == p)
                {
                    let UserDetailsVc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
                    UserDetailsVc.myStringValue = nameTextCheck.text
                    self.navigationController?.pushViewController(UserDetailsVc, animated: true)
                }
                else if (searchString == n || searchString2 == p)
                {
                    let alertController1 = UIAlertController (title: "no user found", message: "password incorrect", preferredStyle: UIAlertControllerStyle.alert)
                    alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController1, animated: true, completion: nil)
                }
            }
            else
            {
                let alertController1 = UIAlertController (title: "no user found", message: "invalid username", preferredStyle: UIAlertControllerStyle.alert)
                alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController1, animated: true, completion: nil)
                print("no user found")
            }
        }
        catch
        {
            print("error")
        }
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
