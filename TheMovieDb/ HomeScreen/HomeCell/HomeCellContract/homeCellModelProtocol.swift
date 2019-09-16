//
//  homeCellModelProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/16/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
protocol HomeCellModelProtocol {
    func getName() -> String
    func getPopularity() -> Double
    func getImagePath() -> String
    func requestImage(imgUrl: String ,indexPath: IndexPath, completion: @escaping (_ data: Data?, _ indexPath: IndexPath) -> ())
}
