//
//  HomeTableViewCell.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/30/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    
    var cellDelegate: CellProtocol?

   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

    
    func setCell(person :Person, indexPath: IndexPath){
       //profileImage.image = nil
        if person.profile_path != nil {
        
     cellView.layer.setCornerRadious(radious: 10, maskToBounds: false)
     cellView.layer.setShadow(opacity: 0.1, radious: 10, shadowColor: UIColor.darkGray.cgColor)
        cellDelegate?.loadImage(urlStr: person.profile_path!,indexPath: indexPath ,completion: {data, indexPath in
            DispatchQueue.main.async {
                let arr = self.cellDelegate?.getvisibleRows()
                if arr != nil {

                    if (arr?.contains(indexPath))!{
                
                        let currentCell = self.cellDelegate?.getCellWithIndexPath(indexPath: indexPath)
                        
                        if currentCell != nil {
                            self.profileImage = currentCell?.viewWithTag(1) as? UIImageView
                            if self.profileImage != nil {
                                if data != nil {
                                    self.profileImage.image = UIImage(data: data!)
                                }else {
                                    self.profileImage.image = UIImage(named: "noimage.png")
                                }
                           
                        }
                        }
                    }
                }
            }
            
        })
    }else {
    self.profileImage.image = UIImage(named: "noimage.png")
    }
        
       if person.name != nil {
            nameLabel.text = person.name!
        }else {
            nameLabel.text = "no name available"
        }
    
        if person.popularity != nil {
            popLabel.text = "\(person.popularity!)"
        } else {
            popLabel.text = "no popularity available"
        }
//        if person.profile_path != nil {
//            
//            actor.requestImage(imgUrl: person.profile_path!, completion: {data in
//               
//                DispatchQueue.main.async {
//                    if data != nil {
//                        self.profileImage.image = UIImage(data: data!)
//                        
//                    } else {
//                        
//                        self.profileImage.image = UIImage(named: "noimage.png")
//                    }
//                   
//                }
//                
//                 
//                
//            })
//        }
        
    }
  
}
