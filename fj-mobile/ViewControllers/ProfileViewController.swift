//
//  ProfileViewController.swift
//  fj-mobile
//
//  Created by Tony Cioara on 4/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ImageSelectionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentCell: ProfileInfoCell?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadUser {
            DispatchQueue.main.async {
                print("USER: \(self.user!.profile_image_file_url)")
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileInfoCell", for: indexPath) as! ProfileInfoCell
        
        cell.selectionStyle = .none
        guard let user = self.user else {return cell}
        
        cell.emailLabel.text = user.email
        cell.firstNameLabel.text = user.first_name
        cell.lastNameLabel.text = user.last_name
        cell.nicknameLabel.text = user.nickname
        cell.profileImageView.loadImageFromUrlString(urlString: user.profile_image_file_url)
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
    
    func didClickSelectButton(cell: ProfileInfoCell) {
        self.currentCell = cell
        selectImage()
    }
}

extension ProfileViewController {
    func loadUser(completion: @escaping ()->()) {
        Network.instance.fetch(route: .getCurrentUser) { (data, resp) in
            print(resp)
            let jsonUser = try? JSONDecoder().decode(User.self, from: data)
            if let user = jsonUser {
                self.user = user
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                completion()
            }
        }
    }
}

extension ProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
        self.currentCell?.profileImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

