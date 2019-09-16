//
//  homeCellViewProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/16/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
protocol HomeCellViewProtocol {
    func setName(name: String)
    func setPopularity(popularity: Double)
    func setImage(image: Data)
    func setPlaceHolderImage(imgName: String)
    func getvisibleRows() -> [IndexPath]
    func getCellWithIndexPath(indexPath: IndexPath) -> HomeTableViewCell?
    func setCurrentCell(cell: HomeTableViewCell?)
}
