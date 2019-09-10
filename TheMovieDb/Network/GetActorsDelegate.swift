//
//  GetActorsDelegate.swift
//  Movies Home
//
//  Created by sara.galal on 9/9/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation


protocol GetActorsDelegate {
    func receivingData(data: Data)
    
}

protocol GetImageDelegate {
    func imageReceived (data: Data?)
    
}

protocol GetAllActorImages {
    func imgurlReceived (data: Data?)
    
}

