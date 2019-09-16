//
//  HomeCellPresenterImplementation.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/16/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

class HomeCellProtocolImplmentation: HomeCellPresenterProtocol {
  
    var cellViewProtocol: HomeCellViewProtocol?
    var cellModelProtocol: HomeCellModelProtocol?
    
    init(cellViewProtocol: HomeCellViewProtocol, cellModelProtocol: HomeCellModelProtocol){
        self.cellModelProtocol = cellModelProtocol
        self.cellViewProtocol = cellViewProtocol
    }
    func setCell(indexPath: IndexPath) {
        cellViewProtocol?.setName(name: cellModelProtocol?.getName() ?? "")
        cellViewProtocol?.setPopularity(popularity: cellModelProtocol?.getPopularity() ?? 0.0)
        if cellModelProtocol?.getImagePath() != "" {
        self.getImage(with: (cellModelProtocol?.getImagePath())!, index: indexPath)
        }
    }
    
    func getImage(with urlStr: String, index indexPath: IndexPath) {
        cellModelProtocol?.requestImage(imgUrl: urlStr, indexPath: indexPath, completion: {data,ind  in
        
            DispatchQueue.main.async {
                let arr = self.cellViewProtocol?.getvisibleRows()
                if arr != nil {
                    
                    if (arr?.contains(ind))!{
                       let currentCell = self.cellViewProtocol?.getCellWithIndexPath(indexPath: indexPath)
                        if currentCell != nil {
                            self.cellViewProtocol?.setCurrentCell(cell: currentCell)
                         
                            if data != nil {
                                self.cellViewProtocol?.setImage(image: data!)
                            } else {
                                self.cellViewProtocol?.setPlaceHolderImage(imgName: "noimage.png")
                            }
                        }
                    }
                }
            }
            
        })
    }
    
    
}
