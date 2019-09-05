//
//  NavigationClass.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/3/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit


class NavigationClass: NavigatorDelegate ,BackDelegate {
   
    
        enum Destination {
            case details(person: Person)
            case savePhoto(photo: UIImage)
        }
        
        private weak var navigationController: UINavigationController?
    
    
       init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
        
    func navigate(to destination: NavigationClass.Destination) {
        let viewController = makeViewController(for: destination)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
   
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        
        case .details(let person):
            let storyBoard = UIStoryboard(name: "Details_Storyboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
            vc.person = person
         //  let nav = UIStoryboard(name: "Details_Storyboard", bundle: nil).instantiateInitialViewController()
            return vc
        case .savePhoto(let photo):
            let storyBoard = UIStoryboard(name: "Details_Storyboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "photoVC") as! PhotoVC
            vc.imageSave = photo
            return vc
        }
        
       
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
        
}

