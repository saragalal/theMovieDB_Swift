//
//  savePhotoModel.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/18/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

class SavePhotoModel: SavePhotoModelProtocol{
    private var imgURLStr: String?
    
    init(imgString: String?){
        self.imgURLStr = imgString
    }
    
    func getimgURL() -> String?{
    return self.imgURLStr
    }
}
