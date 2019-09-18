//
//  DetailsPresenterImplementation.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/17/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

class DetailsPresenterImplementation: DetailsPresenterProtocol {
   
    var detailsView: DetailsViewProtocol?
    var detailsModel: DetailsModelProtocol?
    var imgsbaseUrl = "https://api.themoviedb.org/3/person/"
    var baseimgURL = "https://image.tmdb.org/t/p/original"
    var photoViewController: SavePhotoViewContoller?
    init(detailsView: DetailsViewProtocol, detailsModel: DetailsModelProtocol){
        self.detailsView = detailsView
        self.detailsModel = detailsModel
    }
    func detailsInit() {
     if detailsModel?.getActorId() != 0 ,detailsModel?.getActorId() != nil{
        detailsModel?.requestAllImage(imgUrl: imgsbaseUrl, id: (detailsModel?.getActorId())!, completion:{ result in
                if result {
                    self.detailsView?.updateCollectionView()
                }
            })
        }
    }
    func getCollectionImagesCount() -> Int {
        if let count = detailsModel?.getCount() {
            return count
        }
        return 0
    }
    
    func setCollectionViewCell() {
        
    }
    
    func getImageUrlForItem(at index: Int)  -> String{
        if let imgURL = detailsModel?.getImageURL(index: index){
            return baseimgURL+imgURL
        }
        return ""
    }
    func getCurrentActor() -> DetailsModel? {
        return detailsModel?.getActor()
    }
    func profileImageIsSelected() {
        if let photoView = self.detailsView?.instatiatePhotoView(){
            self.photoViewController = photoView
            if let profileImage = detailsModel?.returnProfileImage(){
                let photoModel: SavePhotoModelProtocol = SavePhotoModel(imgString: profileImage)
                photoView.savePhotoPresenter = SavePhotoPresenter(savephotoModel: photoModel, savephotoView: photoView)
                self.detailsView?.navigateToPhotoScreen(photoView: photoView)
            }
        }
    }
    func cellSelected(at index: Int){
        if let photoView = self.detailsView?.instatiatePhotoView(){
            self.photoViewController = photoView
            if let selectedImage = detailsModel?.returnImagePath(at: index){
                let photoModel: SavePhotoModelProtocol = SavePhotoModel(imgString: selectedImage)
                photoView.savePhotoPresenter = SavePhotoPresenter(savephotoModel: photoModel, savephotoView: photoView)
                self.detailsView?.navigateToPhotoScreen(photoView: photoView)
            }
        }
    }
}
