//
//  CALayer+extensions.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/3/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import UIKit


extension CALayer {
    func setCornerRadious(radious : CGFloat, maskToBounds : Bool){
        self.cornerRadius = radious
        self.masksToBounds = maskToBounds
    }
    
    func setShadow(opacity : Float , radious : CGFloat , shadowColor : CGColor){
        self.shadowColor = shadowColor
        self.shadowOpacity = opacity
        self.shadowOffset = CGSize.zero
        self.shadowRadius = radious
    }
    
    
    func setBorder(borderColor : CGColor ,  width : CGFloat ){
        self.borderColor = borderColor
        self.borderWidth = width
    }
}
