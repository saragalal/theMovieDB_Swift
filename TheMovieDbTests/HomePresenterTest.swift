//
//  HomePresenterTest.swift
//  TheMovieDbTests
//
//  Created by sara.galal on 9/22/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import XCTest
@testable import TheMovieDb
class HomePresenterTest: XCTestCase {
    var sut: HomePresenterImplementaion?
    var viewMock: ViewMock?
    var modelMock: ModelMock?
    override func setUp() {
        viewMock = ViewMock()
        modelMock = ModelMock()
        sut = HomePresenterImplementaion(viewProtocol: viewMock!, modelProtocol: modelMock!)
       
    }

    override func tearDown() {
        sut = nil
        viewMock = nil
        modelMock = nil
        super.tearDown()
    }
    
    // Return Array Count test
    func testGetArrayCount() {
        let exp = expectation(description: "receiving data from model")
        modelMock!.jsonFile = "response"
        modelMock!.actorsList = []
        modelMock!.requestActorList(urlStr: "", page: 1, completion: { (success) in
            if success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 3,"Arraycount should return 3")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
    }
    func testGetEmptyArrayCount(){
        let exp = expectation(description: "receiving data from model")
        modelMock!.jsonFile = "emptyResponse"
        modelMock!.actorsList = []
        modelMock!.requestActorList(urlStr: "", page: 1, completion: { (success) in
            if success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 0,"Arraycount should be empty")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
    }
}
