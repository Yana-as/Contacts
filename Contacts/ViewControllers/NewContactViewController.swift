//
//  NewContactViewController.swift
//  Contacts
//
//  Created by Yana on 16.07.2020.
//  Copyright © 2020 YanaInc. All rights reserved.
//

import UIKit

class NewContactViewController: UITableViewController {
    
    var newContact = Contact()
    var imageIsChanged = false
    
    @IBOutlet weak var contactPhoto: UIImageView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactPhoneNumber: UITextField!
    @IBOutlet weak var contactEmail: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Clear stripes under textfields
        tableView.tableFooterView = UIView()
        
        //Creation round photo displaying
        photoView.layer.cornerRadius = photoView.frame.width/2
        photoView.clipsToBounds = true
        
        // Enable save button without require textfields
        saveButton.isEnabled = false
        
        // Checkind completing required textfields
        contactName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        contactPhoneNumber.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    // Choosing method of adding new photo
    @IBAction func addNewPhoto(_ sender: UIButton) {
        
        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            
            self.chooseImagePicker(source: .photoLibrary)
        }
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
}

// MARK: -Work with image
extension NewContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        contactPhoto.image = info[.editedImage] as? UIImage
        contactPhoto.contentMode = .scaleAspectFill
        contactPhoto.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
}

// MARK: -Text field delegate
extension NewContactViewController: UITextFieldDelegate{
    
    // Hiding keyboard to tap on button Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        
        if contactName.text?.isEmpty == false && contactPhoneNumber.text?.isEmpty == false{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
