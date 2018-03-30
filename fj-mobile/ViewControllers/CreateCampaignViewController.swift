//
//  CreateCampaignViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/19/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class CreateCampaignViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var goalTextField: UITextField!
    @IBAction func uploadImageButton(_ sender: Any) {
        
    }
    
    @IBAction func postButton(_ sender: Any) {
        postCampaign {
            DispatchQueue.main.async {
                print("DONE")
            }
        }
    }
}

extension CreateCampaignViewController {
    func postCampaign(completion: @escaping () -> ()) {
        guard let description = descriptionTextView.text else {return}
        guard let goal = Int(goalTextField.text!) else {return}
        guard let title = titleTextField.text else {return}
        
        Network.instance.fetch(route: .postCampaign(title: title, description: description, goal: goal)) { (data, resp) in
            print("done \(resp)")
            completion()
        }
    }
}
