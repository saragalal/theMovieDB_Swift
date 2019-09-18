//
//  SavePhotoPresenter.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/18/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
class SavePhotoPresenter : SavePhotoPresenterProtocol{
   
    var savephotoModel: SavePhotoModelProtocol?
    var savephotoView: SavePhotoViewProtocol?
    
    init(savephotoModel: SavePhotoModelProtocol ,savephotoView: SavePhotoViewProtocol?) {
        self.savephotoView = savephotoView
        self.savephotoModel = savephotoModel
    }
    func getImgUrlFromModel() -> String {
        if let imgURL = savephotoModel?.getimgURL(){
            return imgURL
        }
        return ""
    }
    func saveButtonIsPressed() {
        savephotoView?.savePhoto()
    }
    
 }
