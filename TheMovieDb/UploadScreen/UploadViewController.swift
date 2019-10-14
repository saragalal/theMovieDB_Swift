//
//  UploadViewController.swift
//  TheMovieDb
//
//  Created by sara.galal on 10/9/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire
import SWXMLHash
import SwiftyXMLParser
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    let imagePicker = UIImagePickerController()
    var imageFile: UIImage!
    var photoid = ""
    
   
    let oauthswift = OAuth1Swift(
        consumerKey:    "a108bfdc392aec8bdeac9a782c1dd920",
        consumerSecret: "32e9b5ed612274f8",
        requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
        authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
        accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadBtn.isHidden = true
        imagePicker.delegate = self
 }
    
    @IBAction func chooseImageFromGallery(_ sender: Any) {
        self.openGallery()
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        
        // authorize
        _ = oauthswift.authorize(
            withCallbackURL: URL(string: "oauth-swift://oauth-callback/flickr")!) { result in
                switch result {
                case .success(let (credential, _, parameters)):
                    print("oauthToken",credential.oauthToken)
                    print("oauthTokenSecret",credential.oauthTokenSecret)
                    let data = self.imgView.image!.pngData()
                    let outhClient = OAuthSwiftClient(credential: credential)
                    let date = Date()
                    let calendar = NSCalendar.current
                    let components = calendar.dateComponents([.nanosecond], from: date)
                    let nanoSeconds = components.nanosecond
                    let imgName = "img_" + "\(nanoSeconds!)"
                    let imgData = OAuthSwiftMultipartData(name: "photo", data: data!, fileName: imgName, mimeType: "png")
                    let multiparts = [imgData]
                    outhClient.postMultiPartRequest("https://up.flickr.com/services/upload/", method: .POST, parameters: parameters, multiparts: multiparts, completionHandler: {
                        resultImg in
                        switch resultImg {
                        case .success(let response):
                            let xml = SWXMLHash.parse(response.data)
                            self.photoid = xml["rsp"]["photoid"].element!.text
                            guard let url = URL(string: "http://www.flickr.com/photos/upload/edit/?ids="+self.photoid) else { return }
                            UIApplication.shared.open(url)
                           case .failure(let error):
                            print(error)
                        }
                        })

                    
                // Do your request
                    
//                    let dataimg = UIImage(named: "bookmark.png")?.pngData()
       
//                    let headers = ["Authorization" :]
//
//                    Alamofire.upload(multipartFormData: { multipartFormData in
//                        multipartFormData.append(data!, withName: "photo")
//                    }, to: "https://up.flickr.com/services/upload/", method: .post, headers: headers, encodingCompletion:{
//                        encodingResult in
//                        switch encodingResult {
//                        case .success(let upload, _, _):
//                            print(upload)
//                            upload.responseData{
//                                response in
//                                let string1 = String(data: response.data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
//                                print(string1)
//
//                              let xml = SWXMLHash.parse(response.data!)
//                                   print(xml["rsp"]["photoid"].element?.text)
//                    }
//                        case .failure(let encodingError):
//                            print(encodingError)
//                        }
//                    })

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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
