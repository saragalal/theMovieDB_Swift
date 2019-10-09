//
//  ActorsList.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/15/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation


class HomeModel: Codable, GetActorsDelegate,HomeModelProtocol {
    
    var actorsList = [Actor?]()
    
    var networkDelegate = Network()
    
    var updateUI : ((HomeModel?)->())?
    var listReceived : ((Bool)-> ())?
    
    init() {
       networkDelegate.getActorDelegate = self
    }
    enum ResultKey: String, CodingKey {
        case results = "results"
    }
    required init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: ResultKey.self)
        actorsList = try container.decodeIfPresent([Actor?].self, forKey: .results)!
        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ResultKey.self)
        try container.encode(actorsList, forKey: .results)
    }
    
    func requestActorList (urlStr: String, page: Int, completion: @escaping (_ result: Bool) -> ()){
        networkDelegate.getData(urlString: urlStr, page_no: page)
        listReceived = completion
    }
  
    func receivingData(data: Data?) {
        if data != nil {
        do {
            let result = try JSONDecoder().decode(HomeModel.self, from: data!)
            self.actorsList = result.actorsList
           self.listReceived?(true)
        } catch {
             print("json error \(error)")
        }
      }
        else {
           self.listReceived?(false)
        }
       
    }

func returnArrayCount() -> Int {
        return actorsList.count
    }
    
    func returnActor(at index: Int) -> Actor? {
        if let actorSelected = actorsList[index] {
            return actorSelected
        }
        return nil
    }
    
    func removeData() {
        actorsList = []
    }
}

