//
//  Actors.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/10/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import  UIKit

class Actors: GetActorsDelegate {
    
    var actors = [Person]()

    var networkDelegate = Network()
    
    var updateUI : ((Actors?)->())?
    
 init() {
    
  networkDelegate.getActorDelegate = self
  
   }
    
    func requestActorArray (urlStr: String, page: Int, complation: @escaping (_ result: Actors?) -> () ){
        networkDelegate.getData(urlString: urlStr, page_no: page)
        updateUI = complation 
    }
    
    func receivingData(data: Data) {
        actors = []
       
        
        do {
            let dic = try JSONSerialization.jsonObject(with: data , options: []) as? NSDictionary
            //                print("dic resposne \(dic!)")
            if dic != nil {
                let results = dic?["results"] as? [NSDictionary]
                
                if (results != nil){
                    for result in results!{
                        let person = Person()
                        person.initWithDictionary(dict: result)
                        let works = result["known_for"] as? [NSDictionary]
                        
                        for work in works ?? [] {
                            let w = Works()
                            w.initWithDictionary(dict: work)
                            person.knowFor.append(w)
                        }
                        
                        self.actors.append(person)
                    }
                    let receivedActor = Actors()
                    receivedActor.actors = self.actors
                  self.updateUI?(receivedActor)
                }
            }
        }
            
        catch {
            print("json error \(error)")
        }
    }
}
