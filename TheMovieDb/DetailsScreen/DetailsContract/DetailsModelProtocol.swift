//
//  DetailsModelProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/17/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

protocol DetailsModelProtocol {
    func requestAllImage(imgUrl: String ,id: Int ,completion: @escaping (_ sucess: Bool) -> ())
    func getActorId() -> Int
    func getCount() -> Int
    func getImageURL(index: Int) -> String
    func getActor() -> DetailsModel?
    func returnProfileImage() -> String?
    func returnImagePath(at cell: Int) -> String?
}
