//
//  ViewMock.swift
//  TheMovieDbTests
//
//  Created by sara.galal on 9/22/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import UIKit
@testable import TheMovieDb
class ViewMock: HomeViewProtocol{
    func updateTableView() {
        
    }
    
    func instatiateDetailsView() -> DetailsViewController? {
        let storyboard = UIStoryboard(name: "Details_Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        return vc
    }
    
    func naviagteToDetails(detailsView: DetailsViewController) {
        
    }
}
