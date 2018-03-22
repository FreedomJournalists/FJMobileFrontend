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
    func showData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate (format: "name == %@", myStringValue!)
        do
        {
            let result = try context.fetch(request)
            if result.count > 0
            {
                let nameData = (result[0] as AnyObject).value(forKey: "name") as! String
                let nicknameData = (result[0] as AnyObject).value(forKey: "nickname") as! String
                let emailData = (result[0] as AnyObject).value(forKey: "email") as! String
                nameText.text = nameData
                nicknameText.text = nicknameData
                emailText.text = emailData
            }
        } catch {print(error)}
    }
}
