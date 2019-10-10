//
//  OAuthHelper.swift
//  TheMovieDb
//
//  Created by sara.galal on 10/10/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import OAuthSwift

struct OAuthHelper {
// create an instance and retain it
let oauthswift = OAuth1Swift(
    consumerKey:    "********",
    consumerSecret: "********",
    requestTokenUrl: "https://api.twitter.com/oauth/request_token",
    authorizeUrl:    "https://api.twitter.com/oauth/authorize",
    accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
)
// authorize
    func getAuthorization(){
        _ = oauthswift.authorize(
   withCallbackURL: URL(string: "oauth-swift://oauth-callback/twitter")!) { result in
    switch result {
    case .success(let (credential, response, parameters)):
        print(credential.oauthToken)
        print(credential.oauthTokenSecret)
        print(parameters["user_id"])
        print(response)
    // Do your request
    case .failure(let error):
        print(error.localizedDescription)
      }
     }
    }
}
