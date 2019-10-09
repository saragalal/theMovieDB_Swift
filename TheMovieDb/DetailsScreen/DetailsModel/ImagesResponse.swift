//
//  ImagesResponse.swift
//  TheMovieDb
//
//  Created by sara.galal on 10/9/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import ObjectMapper
struct ImagesResponse: Mappable {
    var profiles = [ImagePath]()
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
         profiles    <- map["profiles"]
    }
}
struct ImagePath: Mappable {
    var profilePath: String?
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        profilePath    <- map["file_path"]
    }
}
