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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    let keychain = KeychainSwift()
    
    var user: User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        
//        self.keychain.delete("fjToken")
        
//        if let token = self.keychain.get("fjToken") {
//            print("GOT HERE")
//            print(token)
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "campaignsSegue", sender: self)
//            }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {

//        self.keychain.delete("fjToken")
        
        if let token = self.keychain.get("fjToken") {
            print("GOT HERE")
            print(token)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "campaignsSegue", sender: self)
            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.addCharacterSpacing(spacing: 4)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func SignInButtonTop(_ sender: Any) {
        print("SignIn Button Tapped")
        
        logInUser {
            DispatchQueue.main.async {
                self.keychain.set(self.user!.token, forKey: "fjToken")
                
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

extension SignInViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterUserViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
