//
//  DetailsPresenterProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/17/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
protocol DetailsPresenterProtocol {
    func detailsInit()
    func getCollectionImagesCount() -> Int
    func setCollectionViewCell()
    func getImageUrlForItem(at index: Int) -> String
    func getCurrentActor() -> DetailsModel?
    func profileImageIsSelected()
     func cellSelected(at index: Int)
}
