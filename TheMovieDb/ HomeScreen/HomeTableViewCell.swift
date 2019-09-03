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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(person :Person){
        cellView.layer.setCornerRadious(radious: 10, maskToBounds: false)
        cellView.layer.setShadow(opacity: 0.1, radious: 10, shadowColor: UIColor.darkGray.cgColor)
        
        
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
        if person.profile_path != nil {
            getImage(urlString: person.profile_path!)
        } else {
            profileImage.image = UIImage(named: "noimage.png")
        }
    }
  
    func getImage(urlString: String){
       
        let url = URL(string: "https://image.tmdb.org/t/p/w500"+urlString)

        
        
        let task = URLSession.shared.dataTask(with: url!){ (data, resonse , error) in
            if error == nil && data != nil{
                
    
                let loadedImage = UIImage(data: data!)

                  DispatchQueue.main.async {
                    self.profileImage.image = loadedImage
                    self.profileImage.layer.masksToBounds = false
                    
                    self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
                    self.profileImage.clipsToBounds = true

                }
            }else {
                DispatchQueue.main.async{
                    self.profileImage.image = UIImage(named:"noimage.png")
                }
            }
       
        }
        task.resume()
    }
}
