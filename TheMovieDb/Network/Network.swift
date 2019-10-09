//
//  GetActors.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/10/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class Network {
    var getActorDelegate :GetActorsDelegate?
    var getImageDelegate : GetImageDelegate?
 
    var getAllImages: GetAllActorImages?
    
    let imageCache = NSCache<NSString, NSData>()
    let reponseCaching = NSCache<NSString, NSData>()
   
//func getData(urlString : String , page_no: Int){
//
//    let urlStr :String  = urlString+"&page="+"\(page_no)"
//
//        let url :URL = URL(string: urlStr)!
//
//        let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
//            if error == nil {
//                do{
//                    if self.getActorDelegate != nil {
//                        self.reponseCaching.setObject(data! as NSData, forKey: urlStr as NSString)
//                        do {
//                            let dic = try JSONSerialization.jsonObject(with: data! , options: []) as? NSDictionary
//                            print("dic resposne \(dic!)")
//                        }catch {
//
//                        }
//                        self.getActorDelegate!.receivingData(data: data)
//                    }
//                }
//            } else {
//                 self.getActorDelegate!.receivingData(data: nil)
//            }
//        }
//        task.resume()
//    }
    func getData(urlString : String , page_no: Int){
        let urlStr :String  = urlString+"&page="+"\(page_no)"
        Alamofire.request(urlStr, method: .get).responseData
            {  response in
                //printing response
                print(response)
                switch (response.result){
                case .success(_):
                    print("success")
                    if let result = response.result.value {
                         self.getActorDelegate!.receivingData(data: result)
                    }
                 case .failure(_):
                    print("fail")
                    self.getActorDelegate!.receivingData(data: nil)
                }
                
        }
    }
    
    
    func getImage(urlString: String, indexPath: IndexPath){
        let fullStr = "https://image.tmdb.org/t/p/original"+urlString
        
        let url = URL(string: fullStr)
    let task = URLSession.shared.dataTask(with: url!){ (data, resonse , error) in
            if error == nil {
              
                if self.getImageDelegate != nil {
                    self.getImageDelegate!.imageReceived(data: data, indexPath: indexPath)
                }

           }
        }
        task.resume()
    }
    func getActorImages(urlString: String,id: Int){
     
            let urlString = urlString+"\(id)"+"/images?api_key=facd2bc8ee066628c8f78bbb7be41943"
            
            let url :URL = URL(string: urlString)!
            
            let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
                do{
                    if (data != nil){
                        if self.getAllImages != nil {
                        self.getAllImages!.imgurlReceived(data: data!)
                        }

                }
            }
        }
            task.resume()
        }
    
    
    
    
    
}
