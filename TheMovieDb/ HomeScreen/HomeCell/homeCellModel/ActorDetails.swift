//
//  ActorDetails.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/15/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation


class ActorDetails  {
    
    var title :String?
    var vote :Int?
    var type :String?
    var overview :String?
    
    
    init() {
        title = ""
        vote = 0
        type = ""
        overview = ""
        
    }
    func initWithDictionary(dict : NSDictionary){
        title = dict["title"] as? String
        vote = dict["average_vote"] as? Int
        type = dict["media_type"] as? String
        overview = dict["overview"] as? String
        
    }
    
}
