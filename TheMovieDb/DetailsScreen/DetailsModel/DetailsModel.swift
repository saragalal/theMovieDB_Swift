//
//  File.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/17/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import ObjectMapper
class DetailsModel: Actor, GetAllActorImages, DetailsModelProtocol{
    var imageArray = [ImagePath]()
    var getImageUrls: ((Bool) -> ())?
    
    override init(actor: Actor) {
       super.init(actor: actor)
        network.getAllImages = self
      }
    
    required init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
        network.getAllImages = self
    }
    func getActorId() -> Int {
        if let actorId = self.id {
            return actorId
        }
        return 0 
    }
    
    func requestAllImage(id: Int ,completion: @escaping (_ sucess: Bool) -> () ){
            network.getActorImages(id: id)
            getImageUrls = completion
        }
        
        func imgurlReceived(data: String?) {
            if let jsondata = data {
            do{
              
                let imgsURL = Mapper<ImagesResponse>().map(JSONString: jsondata)
                self.imageArray = imgsURL!.profiles
                 self.getImageUrls?(true)
                }
        }else {
            self.getImageUrls?(false)
      }
    }
    func getCount() -> Int {
        return imageArray.count
    }
    func getImageURL(index: Int) -> String{
        if let imgUrl = imageArray[index].profilePath {
        return imgUrl
        }
        return ""
    }
    func getActor() -> DetailsModel? {
        return self
    }
    func returnProfileImage() -> String? {
        return self.profile_path
    }
    func returnImagePath(at cell: Int) -> String? {
        if let imgUrl = self.imageArray[cell].profilePath {
            return imgUrl
        }
        return ""
    }
}
