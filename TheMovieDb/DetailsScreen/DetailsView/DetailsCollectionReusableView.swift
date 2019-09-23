//
//  DetailsCollectionReusableView.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/11/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit
import SDWebImage
class DetailsCollectionReusableView: UICollectionReusableView {
   
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var typeLb: UILabel!
   
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var labeltype: UILabel!

     func setView (actor: DetailsModel) {
        if let actorName = actor.name{
            nameLB.text = actorName
        }
        if actor.knowFor.count != 0 {
        if let actorTitle = actor.knowFor[0]!.title {
            typeLb.text = actorTitle
        } else {
            typeLb.text = "no title available"
        }
        
        if let actorType = actor.knowFor[0]!.type {
            labeltype.text = actorType
        }else {
            typeLb.text = "no type available"
            }
       if let actorOverview = actor.knowFor[0]!.overview{
                overviewText.text = "\(actorOverview)"
       } else {
        overviewText.text = "noi overview available"
            }
        }
        if let actorProfilePath = actor.profile_path {
            self.profileImage.layer.masksToBounds = false
            self.profileImage.layer.cornerRadius = 5
            self.profileImage.clipsToBounds = true
       profileImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original"+actorProfilePath), placeholderImage: UIImage(named: "noimage.png"))
        }
    }
    
}

