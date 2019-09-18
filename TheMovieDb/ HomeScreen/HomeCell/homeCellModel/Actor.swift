//
//  Actor.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/15/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation


class Actor : GetImageDelegate, HomeCellModelProtocol{
    
    
    var id :Int?
    var name : String?
    var knowFor : [ActorDetails?]
    var profile_path : String?
    var popularity : Double?
    var updateImgView : ((Data, IndexPath) -> ())?
    var network = Network()
    
    init() {
        id = 0
        name = ""
        knowFor = []
        profile_path = ""
        popularity = 0.0
        network.getImageDelegate = self
       
    }
    init(actor: Actor){
        self.id = actor.id
        self.name = actor.name
        self.knowFor = actor.knowFor
        self.profile_path = actor.profile_path
        self.popularity = actor.popularity
        network.getImageDelegate = self
    }
    
    func initWithDictionary(dict : NSDictionary){
        id = dict["id"] as? Int
        name = dict["name"] as? String
        profile_path = dict["profile_path"] as? String
        knowFor = dict["known_for"] as? [ActorDetails?] ?? []
        popularity = dict["popularity"] as? Double
        
    }
    
    func requestImage(imgUrl: String ,indexPath: IndexPath, completion: @escaping (_ data: Data?, _ indexPath: IndexPath) -> ()){
        network.getImage(urlString: imgUrl, indexPath: indexPath)
        updateImgView = completion
    }
    
    
    func imageReceived(data: Data?, indexPath: IndexPath) {
        updateImgView?(data! , indexPath)
        
    }
    
    func getName() -> String {
        if let actorName = self.name {
           return actorName
        }
        return "no name available"
    }
    func getPopularity() -> Double {
        if let actorPopularity = self.popularity{
            return actorPopularity
        }
        return 0.0
    }
    func getImagePath() -> String {
        if let imgPath = self.profile_path{
            return imgPath
        }
        return ""
    }
}
