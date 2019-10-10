//
//  UploadViewController.swift
//  TheMovieDb
//
//  Created by sara.galal on 10/9/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    let imagePicker = UIImagePickerController()
    var imageFile: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadBtn.isHidden = true
        imagePicker.delegate = self
 }
    
    @IBAction func chooseImageFromGallery(_ sender: Any) {
        self.openGallery()
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageFile = pickedImage
            self.imgView.image = imageFile
            self.uploadBtn.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.modalPresentationStyle = .overFullScreen
        self.present(imagePicker, animated: false, completion: nil)
    }
}
