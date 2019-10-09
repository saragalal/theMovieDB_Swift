//
//  MoyaNetwork.swift
//  TheMovieDb
//
//  Created by sara.galal on 10/9/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import Moya

enum MoyaService {
    case allImages(id: Int)
}
var apiKey = "facd2bc8ee066628c8f78bbb7be41943"
extension MoyaService: TargetType {
    var baseURL: URL { return URL(string: "https://api.themoviedb.org/3/person/")! }
    var path: String {
        switch self {
        case .allImages(let id):
            return "\(id)"+"/images"
        }
    }
    var method: Moya.Method {
        switch self {
        case .allImages:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .allImages:
            return .requestParameters(
                parameters: ["api_key": apiKey],
                encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .allImages:
            return Data()
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
