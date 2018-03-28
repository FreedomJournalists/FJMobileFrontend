//
//  RegisterUserViewController.swift
//  fj-mobile
//
//  Created by Egon Fiedler on 3/27/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
import KeychainSwift
//import IQKeyboardManagerSwift

class RegisterUserViewController: UIViewController {
        
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    let keychain = KeychainSwift()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IQKeyboardManager.sharedManager().enable = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("SignUp button tapped")
        
        
        ///////////////////////////////////////////////////////
        //The spinning wheel that appears after saving the user
        //        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        //
        //        myActivityIndicator.center = view.center
        //
        //        myActivityIndicator.hidesWhenStopped = false
        //
        //        myActivityIndicator.startAnimating()
        //
        //        view.addSubview(myActivityIndicator)
        

        //                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
        //                print(error)
        //                self.displayMessage(userMessage: "Could not succesfully perform this request. Please try again later")

        
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    
    //Function with the purpose of giving a message depending on where it's been called, you give the content
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

extension RegisterUserViewController {
    func createUser(completion: @escaping () -> ()) {
        guard let firstName = self.firstNameTextField.text, !firstName.isEmpty, let lastName = self.lastNameTextField.text, !lastName.isEmpty,
            let email = self.emailTextField.text, !email.isEmpty, let nickname = self.nicknameTextField.text, !nickname.isEmpty, let password = self.passwordTextField.text,
            !password.isEmpty, let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
                DispatchQueue.main.async {
                    self.displayMessage(userMessage: "Invalid Inputs.")
                }
            return
        }
    
        if password.count < 6 {
            self.displayMessage(userMessage: "Password must be at least 6 characters.")
        }
        
        Network.instance.fetch(route: .createUser(firstName: firstName, lastName: lastName, email: email, nickname: nickname, password: password, confirmPassword: confirmPassword)) { (data, resp) in
            
            if resp.statusCode == 403 {
                DispatchQueue.main.async {
                    self.displayMessage(userMessage: "Username or Email in Use.")
                
                    return
                }
            }
                self.getUser(username: username) {
                    completion()
                }
            
        }
    }


extension RegisterUserViewController {
    func getUser(username: String, completion: @escaping()->()) {
        Network.instance.fetch(route: .getUser(username: username)) { (data, resp)  in
            let jsonUser = try? JSONDecoder().decode(User.self, from: data)
            if let loggedUser = jsonUser {
                self.user = loggedUser
                
                completion()
            }
        }
    }
}
