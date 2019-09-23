//
//  HomePresenterPullToRefreshTest.swift
//  TheMovieDbTests
//
//  Created by sara.galal on 9/23/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import XCTest
@testable import TheMovieDb
class HomePresenterPullToRefreshTest: XCTestCase {

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
    //Pull To refresh Test
    func testPullToRefresh() {
        let exp = expectation(description: "receiving data from model")
        modelMock!.jsonFile = "response"
        modelMock!.actorsList = []
        // when
        modelMock!.requestActorList(urlStr: "", page: 1, completion: { (success) in
            if success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 3,"Arraycount should return 3")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
        sut?.removeDataFromTableView()
        XCTAssertEqual(self.sut?.getActorsListCount(), 0,"Array should be empty")
        //then
        sut?.refeshList()
        XCTAssertEqual(sut?.pageNo, 1 , "should request page one")
        XCTAssertEqual(self.sut?.getActorsListCount(), 3,"Array should request page 1 with count 3")
        XCTAssertEqual(sut?.requestURL, "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc" , "request Url should be for popular actor")
    }
    
   
}

