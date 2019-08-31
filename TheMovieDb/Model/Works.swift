//
//  Works.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/30/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

class Works :NSObject {
  
    var title :String?
    var vote :Int?
    var type :String?
    var overview :String?
    

override init() {
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
