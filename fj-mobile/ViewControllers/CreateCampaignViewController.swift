//
//  CreateCampaignViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/19/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class CreateCampaignViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    let borderColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
    
    var campaignImage: UIImage? {
        didSet {
            self.imageView.image = campaignImage
        }
    }
    
    var campaignId: Int?
    
    
    @IBAction func uploadImageButton(_ sender: Any) {
        selectImage()
    }
    
    @IBAction func postButton(_ sender: Any) {
        postCampaign {
            DispatchQueue.main.async {
                guard let image = self.campaignImage else {return}
                self.uploadImage(image: image)
                self.navigationController?.popToRootViewController(animated: true)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        self.title = "New Campaign"
        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.cornerRadius = 5
        self.imageView.clipsToBounds = true
        self.darkView.layer.cornerRadius = 5
        
        
//        self.titleTextField.layer.borderColor = borderColor.cgColor
//        self.titleTextField.layer.borderWidth = 0.5

        self.descriptionTextView.layer.borderColor = borderColor.cgColor
        self.descriptionTextView.layer.borderWidth = 0.5
        self.descriptionTextView.layer.cornerRadius = 5
        
        self.descriptionTextView.delegate = self
        self.descriptionTextView.text = " Description"
        self.descriptionTextView.textColor = borderColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Hello")
        if textView.textColor == borderColor {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("GoodBye")
        if textView.text.isEmpty {
            textView.text = " Description"
            textView.textColor = borderColor
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 180
            }
//        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 180
            }
//        }
    }
}

extension CreateCampaignViewController {
    func postCampaign(completion: @escaping () -> ()) {
        guard let description = descriptionTextView.text else {
            incompleteAlert()
            return
        }
        guard let goal = Int(goalTextField.text!) else {
            incompleteAlert()
            return
        }
        guard let title = titleTextField.text else {
            incompleteAlert()
            return
        }
//        guard let image = campaignImage else {return}
        
//        // Create path.
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let filePath = URL("\(paths[0])/campaignImage.png")
//        // Save image.
//        UIImagePNGRepresentation(image)?.write(to: filePath)
        
        Network.instance.fetch(route: .postCampaign(title: title, description: description, goal: goal)) { (data, resp) in
            let jsonCampaign = try? JSONDecoder().decode(Campaign.self, from: data)
            if let campaign = jsonCampaign {
                self.campaignId = campaign.id
            completion()
            }
        }
    }
    
    func incompleteAlert() {
        let alert = UIAlertController(title: "Incomplete", message: "Some of the required information is not filled in", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func uploadImage(image: UIImage) {
        guard let imageData = UIImageJPEGRepresentation(image, 1)
            else {return}
        Network.instance.imageUpload(route: .campaignUpload(id: self.campaignId!), imageData: imageData)
    }
}


extension CreateCampaignViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func selectImage() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
//        Add camera button
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
//        Add Photo library button
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
//        Add cancel button
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.campaignImage = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CreateCampaignViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterUserViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
