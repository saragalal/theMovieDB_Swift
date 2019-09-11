//
//  DetailsCollectionViewCell.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/11/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    func setCell(person: Person, urlStr: String){
        
//        person.requestImage(imgUrl: urlStr, completion: {data in
//            
//            DispatchQueue.main.async {
//                if data != nil {
//                    self.imgView.image = UIImage(data: data!)
//                    
//                } else {
//                    
//                    self.imgView.image = UIImage(named: "noimage.png")
//                }
//                
//            }
//            
//            
//        })
            
        }
}
