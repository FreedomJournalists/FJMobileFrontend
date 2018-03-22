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
    
    //On post request
    
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
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //Authentication of right values for the name
    func isValidInput(Input:String) -> Bool
    {

        let RegEx = "\\A\\w{3,18}\\z"
    // Predicates wrap some combination of expressions and operators and when evaluated return a BOOL.
        //public /*not inherited*/ init(format predicateFormat: String, argumentArray arguments: [Any]?)
        let Test = NSPredicate(format: "Self Matches %@", RegEx)
        //PART OF NSPREDICATE
        //open func evaluate(with object: Any?) -> Bool // evaluate a predicate against a single object
        return Test.evaluate(with: Input)
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //Authentication of values for the password
    func isPasswordValid(_ password: String) -> Bool
    {
    // Predicates wrap some combination of expressions and operators and when evaluated return a BOOL.
        //public /*not inherited*/ init(format predicateFormat: String, argumentArray arguments: [Any]?)
        //must have: normal letter, some symbol, a capslock letter and some number
        let passwordTest = NSPredicate(format: "Self Matches %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{3,}")
        //open func evaluate(with object: Any?) -> Bool // evaluate a predicate against a single object
        return passwordTest.evaluate(with: password)
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //
    func isValidEmail(testStr:String) -> Bool {
    // Three parts: [A to Z 0 to 9 a to z and any symbol] + @ [A to Z 0 to 9 a to z] . [A to Z a to z
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    // Predicates wrap some combination of expressions and operators and when evaluated return a BOOL.
        //public /*not inherited*/ init(format predicateFormat: String, argumentArray arguments: [Any]?)
        let emailTest = NSPredicate(format: "Self Matches %@", emailRegEx)
        //PART OF NSPREDICATE
        //open func evaluate(with object: Any?) -> Bool // evaluate a predicate against a single object
        return emailTest.evaluate(with: testStr)
    }
}
