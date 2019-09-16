//
//  HomePresenterProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/16/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
protocol HomePresenterProtocol {
    func viewIsReady() ->()
    func searchIsPressed(text: String) -> ()
    func refeshList() -> ()
    func getActorsListCount() -> Int
    func getSectionNumber() -> Int
    func getCellContaint(at cellNumber: Int) -> Actor
    func cancelSearchButtonIsPressed() ->()
    func removeDataFromTableView() ->()
    func loadNextPage() ->()
}
