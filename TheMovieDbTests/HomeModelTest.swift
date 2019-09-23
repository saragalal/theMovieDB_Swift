//
//  HomeModelTest.swift
//  TheMovieDbTests
//
//  Created by sara.galal on 9/23/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import XCTest
@testable import TheMovieDb
class HomeModelTest: XCTestCase {
    var sut: HomeModel?
    override func setUp() {
        sut = HomeModel()
    }
    override func tearDown() {
        sut = nil
       super.tearDown()
    }

    func testRequestDataUrlSession() {
        // given
        let promise = expectation(description: "Data isReceived")
        
        // when
        XCTAssertEqual(sut?.returnArrayCount(), 0, "actorList should be empty before the data task runs")
        let url = "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc"
        sut?.requestActorList(urlStr: url, page: 1,completion: {success in
            if success {
                promise.fulfill()
            }
        })
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(sut?.returnArrayCount(), 20, "Didn't parse page one from network")
    }
    
    
    func testRequestFailDataUrlSession() {
        // given
        let promise = expectation(description: "Data notReceived")
        
        // when
        XCTAssertEqual(sut?.returnArrayCount(), 0, "actorList should be empty before the data task runs")
        let url = "https://api.themoviedb.org/3/person/popular?api_key=fcd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc"
        sut?.requestActorList(urlStr: url, page: 1,completion: {success in
            if !success {
                promise.fulfill()
            }
        })
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(sut?.returnArrayCount(), 0, "request didn't fail from network")
    }

}
