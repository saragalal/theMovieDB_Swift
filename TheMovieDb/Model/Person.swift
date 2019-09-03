//
//  Person.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/29/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

class Person: NSObject {
    var id :Int?
 var name : String?
 var knowFor : [Works?]
    var profile_path : String?
    var popularity : Double?
    override init() {
        id = 0
        name = ""
        knowFor = []
        profile_path = ""
        popularity = 0.0
    }
    
    func initWithDictionary(dict : NSDictionary){
        id = dict["id"] as? Int
        name = dict["name"] as? String
        profile_path = dict["profile_path"] as? String
        knowFor = dict["known_for"] as? [Works?] ?? []
        popularity = dict["popularity"] as? Double
   
    }
    
}
