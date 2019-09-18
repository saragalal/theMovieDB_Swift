//
//  File.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/17/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

class DetailsModel: Actor, GetAllActorImages, DetailsModelProtocol{
    var imageArray = [String]()
    var getImageUrls: ((Bool) -> ())?
    
    override init(actor: Actor) {
       super.init(actor: actor)
        network.getAllImages = self
      }
    func getActorId() -> Int {
        if let actorId = self.id {
            return actorId
        }
        return 0 
    }
    
    func requestAllImage(imgUrl: String ,id: Int ,completion: @escaping (_ sucess: Bool) -> () ){
            network.getActorImages(urlString: imgUrl, id: id)
            getImageUrls = completion
        }
        
        func imgurlReceived(data: Data?) {
            do{
                let dic = try JSONSerialization.jsonObject(with: data! , options: []) as? NSDictionary
                
                let results = dic?["profiles"] as? [NSDictionary]
                if results != nil {
                   
                    for result in results! {
                        let str = result["file_path"] as? String
                        if str != nil {
                            imageArray.append(str!)
                        }
                    }
                    self.getImageUrls?(true)
                }
            } catch {
                print("json error \(error)")
            }
        }
    
    func getCount() -> Int {
        return imageArray.count
    }
    func getImageURL(index: Int) -> String{
        return imageArray[index]
    }
    func getActor() -> DetailsModel? {
        return self
    }
    func returnProfileImage() -> String? {
        return self.profile_path
    }
    func returnImagePath(at cell: Int) -> String? {
        return self.imageArray[cell]
    }
}
