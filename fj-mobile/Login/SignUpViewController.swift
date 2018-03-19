//
//  SignUpViewController.swift
//  fj-mobile
//
//  Created by Egon Fiedler on 3/18/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SignUpViewController: UIViewController {
    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var nicknameText: UITextField!
    @IBOutlet var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SignUpAction(_ sender: Any) {
        if isValidInput(Input: nameText.text!)
        {
            if isPasswordValid(passwordText.text!)
            {
                if isValidEmail(testStr: emailText.text!)
                {
                    let _:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
                    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as NSManagedObject
                    
                    newUser.setValue(nameText.text, forKey: "name")
                    newUser.setValue(passwordText.text, forKey: "password")
                    newUser.setValue(nicknameText.text, forKey: "nickname")
                    newUser.setValue(emailText.text, forKey: "email")
                    
                    do {
                        try context.save()
                    } catch {}
                    print(newUser)
                    print("Object Saved.")
                    
                    let alertController1 = UIAlertController (title: "Valid", message: "Success", preferredStyle: UIAlertControllerStyle.alert)
                    alertController1.addAction(UIAlertAction(title: "Valid", style: .default, handler: nil))
                    
                    present(alertController1, animated:  true, completion: nil)
                    
                    let UserDetailsVc = self.storyboard?.instantiateInitialViewController(withIdentifier: "LogoutViewController") as! LogOutViewController
                    ////////////// LogOutViewController must be made
                    self.navigationController?.pushViewController(UserDetailsVc, animated: true)
                }
                else
                {
                    print("mail check")
                    let alertController1 = UIAlertController (title: "Fill Email ID", message: "Enter valid email", preferredStyle: UIAlertControllerStyle.alert)
                
                    alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController1, animated:  true, completion: nil)
                }
            }
            else
            {
                print("pswd check")
                let alerController1 = UIAlertController (title: "Fill the password", message: "Enter valid password", preferredStyle: UIAlertControllerStyle.alert)
                alerController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alerController1, animated:  true, completion: nil)
            }
        }
        else
        {
            print("nameCheck")
            let alertController1 = UIAlertController (title: "Fill the Name", message: "Enter valid Username", preferredStyle: UIAlertControllerStyle.alert)
            alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController1, animated: true, completion: nil)
        }
    }
    
    func isValidInput(Input:String) -> Bool
    {
        let RegEx = "\\A\\w{3,18}\\z"
        let Test = NSPredicate(format: "Self Matches %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
    func isPasswordValid(_ password: String) -> Bool
    {
        let passwordTest = NSPredicate(format: "Self Matches %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{3,}")
        return passwordTest.evaluate(with: password)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "Self Matches %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
