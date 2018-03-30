//
//  LoginViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
import KeychainSwift

class SignInViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignInButtonTop(_ sender: Any) {
        print("SignIn Button Tapped")
        
        let keychain = KeychainSwift()
        
        logInUser {
            DispatchQueue.main.async {
                keychain.set(self.user!.token, forKey: "fjToken")
                
                self.performSegue(withIdentifier: "campaignsSegue", sender: self)
            }
        }
        
    }
    @IBAction func newAccountButton(_ sender: Any) {
        print("REGISTER")
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        self.present(registerViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)

                let OKAction = UIAlertAction(title: "OK BOIIII", style: .default)
                { (action:UIAlertAction!) in
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func logInUser(completion: @escaping () -> ()) {
        
        guard let email = emailTextField.text else {
            displayMessage(userMessage: "Email is missing.")
            return
        }
        guard let password = passwordTextField.text else {
            displayMessage(userMessage: "Password is missing.")
            return
        }
    
        Network.instance.fetch(route: .login(email: email, password: password)) { (data, resp) in
            let jsonUser = try? JSONDecoder().decode(User.self, from: data)
            if let user = jsonUser {
                self.user = user
                
                print(user.token)
                completion()
            }
        }
    }
}