//
//  CellViewController.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/11/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class CellViewController: ViewController , CellProtocol {
   
    
    
  
    var person = Person ()
    
    
    var cell: HomeTableViewCell?
    var tableView: UITableView?
    
    func setDelegate (cell: HomeTableViewCell, indexPath: IndexPath, person: Person, table : UITableView)
   {
    self.cell = cell
    cell.cellDelegate = self
    self.tableView = table
    cell.setCell(person: person, indexPath: indexPath)
    }
    
    func loadImage(urlStr: String, indexPath: IndexPath, completion: @escaping (Data? , IndexPath) -> ()) {
        person.requestImage(imgUrl: urlStr,indexPath: indexPath, completion: {data , indexPath in
           completion(data, indexPath)
          //cell    TheMovieDb.HomeTableViewCell    0x00007fb96d874600
             } )
    }
   
    func getvisibleRows() -> [IndexPath]? {
        var array: [IndexPath]?
       
            array = self.tableView?.indexPathsForVisibleRows
        
       return array
    }
    
    func getCellWithIndexPath(indexPath: IndexPath) -> HomeTableViewCell? {
        var cell: HomeTableViewCell?
        cell = self.tableView?.cellForRow(at: indexPath) as? HomeTableViewCell
       
        return cell
    }
    
    
//    func setCellView(cell: HomeTableViewCell, person: Person){
//        cell.setCell(person: person)
//    }
    
    
    
//    func loadImage(urlStr: String, completion: @escaping (_ data: Data?) -> ())) {
//        person.requestImage(imgUrl: urlStr, completion: {data in
//
//
//        } )
//    }
    
   

}
