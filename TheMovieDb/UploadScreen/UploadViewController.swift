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
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    let imagePicker = UIImagePickerController()
    var imageFile: UIImage!
    var results: [[String: String]]?         // the whole array of dictionaries
    var currentDictionary: [String: String]? // the current dictionary
    var currentValue: String?                // the current value for one of the keys in the dictionary
    let recordKey = "rsp"
    let dictionaryKeys = Set<String>(["photoid"])
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
//        if let image = imgView.image {
//            if let data = image.pngData() {
//                var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//                let documentsDirectory: String = paths[0]
//                let filename = documentsDirectory+"img.png"
//                let filenameURL = URL(string: filename)
//                if let filenameurl = filenameURL{
//                try? data.write(to: filenameurl)
//                }
//            }
//        }

        
        // authorize
        _ = oauthswift.authorize(
            withCallbackURL: URL(string: "oauth-swift://oauth-callback/flickr")!) { result in
                switch result {
                case .success(let (credential, _, _)):
                    print("oauthToken",credential.oauthToken)
                    print("oauthTokenSecret",credential.oauthTokenSecret)
            
                // Do your request
                    let data = self.imgView.image!.pngData()
                    let headers = ["Authorization" :"oauth_consumer_key=\"a108bfdc392aec8bdeac9a782c1dd920\",oauth_token=\"72157711274972698-7ed4c9a661a4259e\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1570704190\",oauth_nonce=\"Ftp1mULnQLg\",oauth_version=\"1.0\",oauth_signature=\"15lujQm6pbZWZHviZo%2FvZZwSZP4%3D\""]
                   
                    Alamofire.upload(multipartFormData: { multipartFormData in
                        multipartFormData.append(data!, withName: "photo")
                    }, to: "https://up.flickr.com/services/upload/", method: .post, headers: headers, encodingCompletion:{
                        encodingResult in
                        switch encodingResult {
                        case .success(let upload, _, _):
                            print("s")
                            upload.responseJSON {
                                response in
                                print(response.request)  // original URL request
                                print(response.response) // URL response
                                print(response.data)     // server data
                                print(response.result)   // result of response serialization
                                let parser = XMLParser(data: response.data!)
                                parser.delegate = self
                                if parser.parse() {
                              print(self.results ?? "No results")
                                }
                                //                                            if let JSON = response.result.value {
                                //                                                print("JSON: \(JSON)")
                                //                                            }
                            }
                        case .failure(let encodingError):
                            print(encodingError)
                        }
                    })
                    
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

extension UploadViewController: XMLParserDelegate {
    
    // initialize results structure
    
    func parserDidStartDocument(_ parser: XMLParser) {
        results = []
    }
    
    // start element
    //
    // - If we're starting a "record" create the dictionary that will hold the results
    // - If we're starting one of our dictionary keys, initialize `currentValue` (otherwise leave `nil`)
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == recordKey {
            currentDictionary = [:]
        } else if dictionaryKeys.contains(elementName) {
            currentValue = ""
        }
    }
    
    // found characters
    //
    // - If this is an element we care about, append those characters.
    // - If `currentValue` still `nil`, then do nothing.
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue? += string
    }
    
    // end element
    //
    // - If we're at the end of the whole dictionary, then save that dictionary in our array
    // - If we're at the end of an element that belongs in the dictionary, then save that value in the dictionary
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == recordKey {
            results!.append(currentDictionary!)
            currentDictionary = nil
        } else if dictionaryKeys.contains(elementName) {
            currentDictionary![elementName] = currentValue
            currentValue = nil
        }
    }
    
    // Just in case, if there's an error, report it. (We don't want to fly blind here.)
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        
        currentValue = nil
        currentDictionary = nil
        results = nil
    }
    
}
