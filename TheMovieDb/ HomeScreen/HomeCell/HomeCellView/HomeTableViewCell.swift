//
//  HomeTableViewCell.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/30/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell ,HomeCellViewProtocol{
  
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    var cellPresenter: HomeCellPresenterProtocol?

    var celltableView: UITableView?
    var currentCell: HomeTableViewCell?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(actor :Actor, indexPath: IndexPath, tableview: UITableView){
        celltableView = tableview
        cellView.layer.setCornerRadious(radious: 10, maskToBounds: false)
        cellView.layer.setShadow(opacity: 0.1, radious: 10, shadowColor: UIColor.darkGray.cgColor)
        cellPresenter = HomeCellProtocolImplmentation(cellViewProtocol: self, cellModelProtocol: actor)
        cellPresenter?.setCell(indexPath: indexPath)
    }
    
    func setName(name: String) {
        nameLabel.text = name
    }
    
    func setPopularity(popularity: Double) {
        popLabel.text = "\(popularity)"
    }
    
    func setImage(image: Data) {
         self.profileImage = currentCell?.viewWithTag(1) as? UIImageView
        self.profileImage.image = UIImage(data: image)
    }
    
    func setPlaceHolderImage(imgName: String) {
         self.profileImage = currentCell?.viewWithTag(1) as? UIImageView
         self.profileImage.image = UIImage(named: imgName)
    }
    
    func getvisibleRows() -> [IndexPath]{
        if let array = self.celltableView?.indexPathsForVisibleRows {
             return array
        }
       return []
     }
    
    func getCellWithIndexPath(indexPath: IndexPath) -> HomeTableViewCell? {
        var cell: HomeTableViewCell?
        cell = self.celltableView?.cellForRow(at: indexPath) as? HomeTableViewCell
        return cell
    }
    
    func setCurrentCell(cell: HomeTableViewCell?) {
        currentCell = cell
    }
 
       //profileImage.image = nil
//        if actor.profile_path != nil {
//
//     cellView.layer.setCornerRadious(radious: 10, maskToBounds: false)
//     cellView.layer.setShadow(opacity: 0.1, radious: 10, shadowColor: UIColor.darkGray.cgColor)
//     cellDelegate?.loadImage(urlStr: actor.profile_path!,indexPath: indexPath ,completion: {data, indexPath in
//            DispatchQueue.main.async {
//                let arr = self.cellDelegate?.getvisibleRows()
//                if arr != nil {
//
//                    if (arr?.contains(indexPath))!{
//
//                        let currentCell = self.cellDelegate?.getCellWithIndexPath(indexPath: indexPath)
//
//                        if currentCell != nil {
//                            self.profileImage = currentCell?.viewWithTag(1) as? UIImageView
//                            if self.profileImage != nil {
//                                if data != nil {
//                                    self.profileImage.image = UIImage(data: data!)
//                                }else {
//                                    self.profileImage.image = UIImage(named: "noimage.png")
//                                }
//
//                        }
//                        }
//                    }
//                }
//            }
//
//        })
//    }else {
//    self.profileImage.image = UIImage(named: "noimage.png")
//    }
//
//       if actor.name != nil {
//            nameLabel.text = actor.name!
//        }else {
//            nameLabel.text = "no name available"
//        }
//
//        if actor.popularity != nil {
//            popLabel.text = "\(actor.popularity!)"
//        } else {
//            popLabel.text = "no popularity available"
//        }
 //   }
 }
