//
//  LoginViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func SignInButtonTop(_ sender: Any) {
        print("SignIn Button Toped")
        
        //Read values
        guard let userName = userNameTextField.text else {
            print("user name is missing")
            displayMessage(userMessage: "Username is missing.")
            return
        }
        guard let userPassword = userPasswordTextField.text else {
            print("password is missing")
            displayMessage(userMessage: "Password is missing.")
            return
        }
        
        ///////////////////////////////////////////////////////
        //The spinning waiting for the network call to work
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        myActivityIndicator.center = view.center
        
        myActivityIndicator.hidesWhenStopped = false
        
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
    }
    
    
    @IBAction func registerNewAccountButton(_ sender: Any) {
        print("Account button tapped")
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        self.present(registerViewController, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    
    
    func displayMessage(userMessage: String) -> Void
    {
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
}

