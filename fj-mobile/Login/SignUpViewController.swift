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
import KeychainSwift

class SignUpViewController: UIViewController {
    
    @IBOutlet var nameText: UITextField!
    
    //the two new values
    @IBOutlet var firstNameText: UITextField!
    @IBOutlet var lastNameText: UITextField!
    
    //
    @IBOutlet var nicknameText: UITextField!
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!

    override func viewDidLoad() { super.viewDidLoad() }
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    @IBAction func SignUpAction(_ sender: Any) {
        //First function about the nickname if it
        if isValidInput(Input: nicknameText.text!)
        {
            //Second function about the password if it is valid with all it's characteristics
            if isPasswordValid(passwordText.text!)
            {
                //Third function about the email testing if it follows the structure of one
                if isValidEmail(testStr: emailText.text!)
                {
                    //Related to the beggining of the app
                    let _:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
                    //This is where all the NSManagedObjects are saved
                    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        //Setting the newUser as a NSManagedObject
                        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as NSManagedObject
                    
                    //All the elements been saved on newUser
                    newUser.setValue(firstNameText.text, forKey: "firstName")
                    newUser.setValue(lastNameText.text, forKey: "lastName"  )
                    newUser.setValue(nicknameText.text, forKey: "nickname")
                    newUser.setValue(emailText.text, forKey: "email")
                    newUser.setValue(passwordText.text, forKey: "password")
                    //
                    do {
                        try context.save()
                    } catch {}
                    print(newUser)
                    print("Object Saved.")
                    
                    /////////////////////////////////////////////////////////////////////////////////
                    //
                    //Must send the user through codable to the BackEnd HERE
                    let alertController1 = UIAlertController (title: "Valid", message: "Success", preferredStyle: UIAlertControllerStyle.alert)
                    alertController1.addAction(UIAlertAction(title: "Valid", style: .default, handler: nil))
                    
                    present(alertController1, animated:  true, completion: nil)
            //UserDetails?? is this part working with the userdetaels???
                    let UserDetailsVc = self.storyboard?.instantiateInitialViewController(withIdentifier: "LogoutViewController") as! LogOutViewController

                    self.navigationController?.pushViewController(UserDetailsVc, animated: true)
                }
                else
                {
                    print("mail check")
                    //Getting a UIAlertController
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
