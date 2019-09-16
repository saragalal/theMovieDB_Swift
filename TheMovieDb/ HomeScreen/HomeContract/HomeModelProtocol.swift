//
//  HomeModelPresenter.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/15/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

protocol HomeModelProtocol {
    func requestActorList(urlStr: String, page: Int, completion: @escaping (_ result: Bool) -> ())
    func returnArrayCount() -> Int
    func returnActor(at index: Int) -> Actor
    func removeData() ->()
}
