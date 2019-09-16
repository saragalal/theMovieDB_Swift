//
//  homeCellPresenterProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/16/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
protocol HomeCellPresenterProtocol {
    func setCell(indexPath: IndexPath)
    func getImage(with urlStr: String, index indexPath: IndexPath)
}
