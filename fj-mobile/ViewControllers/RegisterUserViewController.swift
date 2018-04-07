//
//  RegisterUserViewController.swift
//  fj-mobile
//
//  Created by Egon Fiedler on 3/27/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
import KeychainSwift

class RegisterUserViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    var user: User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.addCharacterSpacing(spacing: 4)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("SignUp button tapped")
        
        /////////////////////////////////////////////////////
//        //The spinning wheel that appears after saving the user
//        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
//        myActivityIndicator.center = view.center
//        myActivityIndicator.hidesWhenStopped = false
//        myActivityIndicator.startAnimating()
//        view.addSubview(myActivityIndicator)
        
        let keychain = KeychainSwift()
        
        createUser {
            DispatchQueue.main.async {
                keychain.set(self.user!.token, forKey: "fjToken")
                
                self.performSegue(withIdentifier: "toCampaigns", sender: self)
            }
        }

    }
        
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
        
        self.dismiss(animated: true, completion: nil)
    }
    
//    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
//    {
//        DispatchQueue.main.async
//            {
//                activityIndicator.stopAnimating()
//                activityIndicator.removeFromSuperview()
//        }
//    }
    
    
    //Function with the purpose of giving a message depending on where it's been called, you give the content
    func displayMessage(userMessage: String) -> Void
    {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default)
                { (action:UIAlertAction!) in
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
        }
    }
}


extension RegisterUserViewController {
    
    func createUser(completion: @escaping () -> ()) {
        guard let firstName = self.firstNameTextField.text, !firstName.isEmpty, let lastName = self.lastNameTextField.text, !lastName.isEmpty,
            let email = self.emailTextField.text, !email.isEmpty, let nickname = self.nicknameTextField.text, !nickname.isEmpty, let password = self.passwordTextField.text,
            !password.isEmpty else {
                DispatchQueue.main.async {
                    self.displayMessage(userMessage: "Invalid Inputs.")
                }
            return
        }
    
        if password.count < 6 {
            self.displayMessage(userMessage: "Password must be at least 6 characters.")
            return
        }
        
        Network.instance.fetch(route: .signUp(email: email, firstName: firstName, lastName: lastName, nickname: nickname, password: password)) { (data, resp) in
            
            let jsonUser = try? JSONDecoder().decode(User.self, from: data)
            if let user = jsonUser {
                self.user = user
                
                print(user.token)
                completion()
             
            }
        }
    }
}
