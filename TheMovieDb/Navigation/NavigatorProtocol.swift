//
//  NavigatorProtocol.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/3/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

protocol NavigatorDelegate {
    associatedtype Destination
    func navigate(to destination: Destination)
    
}
protocol BackDelegate {
    func goBack()
}
