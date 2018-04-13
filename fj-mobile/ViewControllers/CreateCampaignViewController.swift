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
    @IBOutlet weak var imageView: UIImageView!
    
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
                self.uploadImage(image: self.campaignImage)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Campaign"
    }
    
    
}

extension CreateCampaignViewController {
    func postCampaign(completion: @escaping () -> ()) {
        guard let description = descriptionTextView.text else {return}
        guard let goal = Int(goalTextField.text!) else {return}
        guard let title = titleTextField.text else {return}
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
