//
//  DetailsCollectionReusableView.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/11/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class DetailsCollectionReusableView: UICollectionReusableView {
   
    @IBOutlet weak var nameLB: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var typeLb: UILabel!
    @IBOutlet weak var overviewLb: UILabel!
    @IBOutlet weak var labeltype: UILabel!

    
    
    
    func setView (person: Person) {
        if person.name != nil {
            nameLB.text = person.name!
        }else {
            nameLB.text = "no name available"
        }
        if person.knowFor.count != 0 {
        if person.knowFor[0]!.title != nil {
            typeLb.text = "\(person.knowFor[0]!.title!)"
        } else {
            typeLb.text = "no title available"
        }
        
        if person.knowFor[0]!.type != nil {
            labeltype.text = "\(person.knowFor[0]!.type!)"
        } else {
            labeltype.text = "no type available"
        }
        } else {
            typeLb.text = "no title available"
            labeltype.text = "no type available"
            
        }
        
       
    }
    
    func setProfImage(img: UIImage){
    
        
                self.profileImage.image = img
  
    }
    
    }

