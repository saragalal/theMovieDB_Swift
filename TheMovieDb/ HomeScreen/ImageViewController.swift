//
//  ImageViewController.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/30/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var imageSave :UIImage!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = imageSave
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(imageSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
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


