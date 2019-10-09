//
//  ActorDetails.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/15/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation


class ActorDetails: Codable  {
    
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
    enum KnownForKeys: String, CodingKey {
        case mediaType = "media_type"
        case overview = "overview"
        case title = "title"
        case voteAverage = "average_vote"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownForKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        vote = try container.decodeIfPresent(Int.self, forKey: .voteAverage)
        type = try container.decodeIfPresent(String.self, forKey: .mediaType)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: KnownForKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(vote, forKey: .voteAverage)
        try container.encode(overview, forKey: .overview)
        try container.encode(type, forKey: .mediaType)
    }
}
