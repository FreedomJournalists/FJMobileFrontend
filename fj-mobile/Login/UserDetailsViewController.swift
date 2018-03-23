//
//  UserDetailsViewController.swift
//  fj-mobile
//
//  Created by Egon Fiedler on 3/18/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserDetailsViewController: UIViewController {
    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var nicknameText: UITextField!
    @IBOutlet var emailText: UITextField!
    
    //Where things are in CoreData
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var myStringValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showData()
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
    }
    ///////////////////////////////////////////////////////////////////////////////////////////
    //
    //Get the information usign CoreData and
    func showData()
    {
        //Getting elements with an entityName
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        // Predicates wrap some combination of expressions and operators and when evaluated return a BOOL.
        //public /*not inherited*/ init(format predicateFormat: String, argumentArray arguments: [Any]?)
        //must have: normal letter, some symbol, a capslock letter and some number
        request.predicate = NSPredicate (format: "name == %@", myStringValue!)
        do
        {
            //
            let result = try context.fetch(request)
            if result.count > 0
            {
                //let nameData = (result[0] as AnyObject).value(forKey: "name") as! String
                let nicknameData = (result[0] as AnyObject).value(forKey: "nickname") as! String
                let emailData = (result[0] as AnyObject).value(forKey: "email") as! String
                //nameText.text = nameData
                nicknameText.text = nicknameData
                emailText.text = emailData
            }
        } catch {print(error)}
    }
}
