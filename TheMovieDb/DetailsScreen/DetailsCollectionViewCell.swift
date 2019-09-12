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
    
    func setImageCell (img: UIImage){
        self.imgView.layer.masksToBounds = false
        self.imgView.layer.cornerRadius = 5
        self.imgView.clipsToBounds = true
        self.imgView.image = img
    
    }
}
