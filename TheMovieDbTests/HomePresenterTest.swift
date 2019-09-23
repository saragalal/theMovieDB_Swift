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
                XCTAssertEqual(self.sut?.getActorsListCount(), 4,"Arraycount should return 4")
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
            if !success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 0,"Arraycount should be empty")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
    }
    
    //Pull To refresh Test
    func testPullToRefresh() {
        //given
        let exp = expectation(description: "receiving data from model")
        modelMock!.jsonFile = "response"
        modelMock!.actorsList = []
        // when
        modelMock!.requestActorList(urlStr: "", page: 1, completion: { (success) in
            if success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 4,"Arraycount should return 4")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
//        sut?.removeDataFromTableView()
//        XCTAssertEqual(self.sut?.getActorsListCount(), 0,"Array should be empty")
        //then
        sut?.refeshList()
        XCTAssertEqual(sut?.pageNo, 1 , "should request page one")
        XCTAssertEqual(self.sut?.getActorsListCount(), 4,"Array should request page 1 with count 4")
        XCTAssertEqual(sut?.requestURL, "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc" , "request Url should be for popular actor")
    }
    
    //LoadMore Test
    func testLoadMore() {
        //given
        let exp = expectation(description: "receiving data from model")
        modelMock!.jsonFile = "response"
        modelMock!.actorsList = []
        // when
        modelMock!.requestActorList(urlStr: "", page: 1, completion: { (success) in
            if success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 4,"Arraycount should return 4")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
        //then
        sut?.loadNextPage()
        XCTAssertEqual(sut?.pageNo, 2 , "page number should increment by one")
        XCTAssertEqual(self.sut?.getActorsListCount(), 8, "Array should append next page result")
    }
    
    func testEmptyLoadMorePage() {
        //given
        let exp = expectation(description: "receiving data from model")
        modelMock!.jsonFile = "response"
        modelMock!.actorsList = []
        // when
        modelMock!.requestActorList(urlStr: "", page: 1, completion: { (success) in
            if success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 4,"Arraycount should return 4")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
        modelMock!.jsonFile = "emptyResponse"
        //then
         
         sut?.loadNextPage()
         XCTAssertEqual(sut?.pageNo, 2 , "page number should increment by one")
         XCTAssertEqual(self.sut?.getActorsListCount(), 4, "Array should be same count")
    }
    
    //GetObject when select Cell
    func testGetObjectofSelectedCell() {
        //given
        let exp = expectation(description: "receiving data from model")
        modelMock!.jsonFile = "response"
        modelMock!.actorsList = []
        // when
        modelMock!.requestActorList(urlStr: "", page: 1, completion: { (success) in
            if success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 4,"Arraycount should return 4")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
        //then
        XCTAssertNotNil(self.sut?.getCellContaint(at: 0), "Actor cell should not return nil")
        let actorName = self.sut?.getCellContaint(at: 0).getName()
        XCTAssertEqual(actorName ,"Ankita Dave","Actor name should be Ankita Dave")
    }
    
    func testGetObjectofSelectedCellEmpty() {
        //given
        let exp = expectation(description: "receiving data from model")
        modelMock!.jsonFile = "response"
        modelMock!.actorsList = []
        // when
        modelMock!.requestActorList(urlStr: "", page: 1, completion: { (success) in
            if success {
                XCTAssertEqual(self.sut?.getActorsListCount(), 4,"Arraycount should return 4")
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 5)
        //then
        XCTAssertNotNil(self.sut?.getCellContaint(at: 3), "Actor cell should not return nil")
        let actorName = self.sut?.getCellContaint(at: 3).getName()
        XCTAssertEqual(actorName ,"no name available","Actor name should be empty")
    }
    
}
