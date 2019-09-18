//
//  DetailsViewProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/17/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

protocol DetailsViewProtocol {
    func updateCollectionView()
    func instatiatePhotoView() -> SavePhotoViewContoller?
    func navigateToPhotoScreen(photoView: SavePhotoViewContoller)
   }
