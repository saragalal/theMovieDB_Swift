//
//  HomeViewProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/15/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

protocol HomeViewProtocol {
    func updateTableView()
    func instatiateDetailsView() -> DetailsViewController?
     func naviagteToDetails(detailsView: DetailsViewController)
}
