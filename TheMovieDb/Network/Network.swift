//
//  GetActors.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/10/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import UIKit

class Network {
    var getActorDelegate :GetActorsDelegate?
    var getImageDelegate : GetImageDelegate?
 
    var getAllImages: GetAllActorImages?
    
    let imageCache = NSCache<NSString, NSData>()
    let reponseCaching = NSCache<NSString, NSData>()
   
func getData(urlString : String , page_no: Int){
    
    let urlStr :String  = urlString+"&page="+"\(page_no)"
    
    if reponseCaching.object(forKey: urlStr as NSString) != nil {
        self.getActorDelegate!.receivingData(data: reponseCaching.object(forKey: urlStr as NSString)! as Data)
    
    }else {
    let url :URL = URL(string: urlStr)!
    
    let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
        do{
            if (data != nil){
                 if self.getActorDelegate != nil {
                    self.reponseCaching.setObject(data! as NSData, forKey: urlStr as NSString)
                 self.getActorDelegate!.receivingData(data: data!)
                }

            }
        }
      
        
    }
    task.resume()
    }
}
    
    
    func getImage(urlString: String, indexPath: IndexPath){
        let fullStr = "https://image.tmdb.org/t/p/original"+urlString
        
        let url = URL(string: fullStr)
        if let cachedVersion = imageCache.object(forKey: fullStr as NSString) {
            self.getImageDelegate!.imageReceived(data: cachedVersion as Data, indexPath: indexPath)
        
    }
    else {
    let task = URLSession.shared.dataTask(with: url!){ (data, resonse , error) in
            if error == nil {
              
                if self.getImageDelegate != nil {
                    self.imageCache.setObject(data! as NSData, forKey: fullStr as NSString)
                    self.getImageDelegate!.imageReceived(data: data, indexPath: indexPath)
                }

           }
            
        }
        task.resume()
    }
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
