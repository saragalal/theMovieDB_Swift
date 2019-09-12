//
//  CellProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/11/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation


protocol  CellProtocol {
    
    func loadImage(urlStr : String, indexPath: IndexPath ,completion: @escaping (_ data: Data?, _ indexPath: IndexPath) -> ())
    func getvisibleRows() -> [IndexPath]?
    func getCellWithIndexPath(indexPath: IndexPath) -> HomeTableViewCell?
}
