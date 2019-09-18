//
//  PhotoVC.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/31/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit
import SDWebImage
class SavePhotoViewContoller: UIViewController ,SavePhotoViewProtocol{
   
    @IBOutlet weak var imgView: UIImageView!
    var savePhotoPresenter: SavePhotoPresenterProtocol?
    var imgUrlString: String = ""
    var imageSave: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlString = savePhotoPresenter?.getImgUrlFromModel() {
             imgUrlString = urlString
        }
       imgView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original"+imgUrlString), placeholderImage: UIImage(named: "noimage.png"))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        imageSave = imgView.image
        savePhotoPresenter?.saveButtonIsPressed()
    }
    func savePhoto() {
        if let img = imageSave {
            UIImageWriteToSavedPhotosAlbum(img, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
/*
 
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


