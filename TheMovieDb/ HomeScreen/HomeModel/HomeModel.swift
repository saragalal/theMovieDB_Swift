//
//  ActorsList.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/15/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation


class HomeModel: GetActorsDelegate,HomeModelProtocol {
    
    var actorsList = [Actor]()
    
    var networkDelegate = Network()
    
    var updateUI : ((HomeModel?)->())?
    var listReceived : ((Bool)-> ())?
    
    init() {
        
        networkDelegate.getActorDelegate = self
    }
    
    func requestActorList (urlStr: String, page: Int, completion: @escaping (_ result: Bool) -> ()){
        networkDelegate.getData(urlString: urlStr, page_no: page)
        listReceived = completion
    }
   func requestActorArray (urlStr: String, page: Int, complation: @escaping (_ result: HomeModel?) -> ()){
        networkDelegate.getData(urlString: urlStr, page_no: page)
        updateUI = complation
    }
    
    func receivingData(data: Data) {
       
        do {
            let dic = try JSONSerialization.jsonObject(with: data , options: []) as? NSDictionary
            //                print("dic resposne \(dic!)")
            if dic != nil {
                let results = dic?["results"] as? [NSDictionary]
                
                if (results != nil){
                    for result in results!{
                        let person = Actor()
                        person.initWithDictionary(dict: result)
                        let works = result["known_for"] as? [NSDictionary]
                        
                        for work in works ?? [] {
                            let w = ActorDetails()
                            w.initWithDictionary(dict: work)
                            person.knowFor.append(w)
                        }
                        
                        self.actorsList.append(person)
                    }
                    let receivedActor = HomeModel()
                    receivedActor.actorsList = self.actorsList
                    //self.updateUI?(receivedActor)
                    self.listReceived?(true)
                }
            }
        }
            
        catch {
            print("json error \(error)")
        }
    }

func returnArrayCount() -> Int {
        return actorsList.count
    }
    
func returnActor(at index: Int) -> Actor {
        return actorsList[index]
    }
    func removeData() {
        actorsList = []
    }
}
