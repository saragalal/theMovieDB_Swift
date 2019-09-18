//
//  DetailsCollectionViewCell.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/11/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit
import SDWebImage
class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    func setImageCell (urlStr: String){
        self.imgView.layer.masksToBounds = false
        self.imgView.layer.cornerRadius = 5
        self.imgView.clipsToBounds = true
        imgView.sd_setImage(with: URL(string: urlStr), placeholderImage: UIImage(named: "noimage.png"))
    
    }
}
