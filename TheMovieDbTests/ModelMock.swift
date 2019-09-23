//
//  ModelMock.swift
//  TheMovieDbTests
//
//  Created by sara.galal on 9/22/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import XCTest
@testable import TheMovieDb
class ModelMock: HomeModelProtocol  {
    var actorsList = [Actor?]()
    var jsonFile = ""
    
    func requestActorList(urlStr: String, page: Int, completion: @escaping (Bool) -> ()) {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: jsonFile, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        if let dataMock = data {
            do {
                let dic = try JSONSerialization.jsonObject(with: dataMock , options: []) as? NSDictionary
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
                            
                            actorsList.append(person)
                        }
                       completion(true)
                    }else {
                        
                        completion(false)
                    }
                }
            }
            catch {
                print("json error \(error)")
            }
        } else {
            
           completion(false)
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
        XCTAssert(true, "Calling removeData")
        actorsList = []
       XCTAssertEqual(self.actorsList.count, 0,"Array should be empty")
    }
    
    
}

