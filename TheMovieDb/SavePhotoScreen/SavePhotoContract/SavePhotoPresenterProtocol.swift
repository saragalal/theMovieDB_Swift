//
//  SavePhotoPresenterProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/18/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
protocol SavePhotoPresenterProtocol {
    func getImgUrlFromModel() -> String
    func saveButtonIsPressed() -> ()
}
