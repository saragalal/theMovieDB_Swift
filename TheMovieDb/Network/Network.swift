//
//  GetActors.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/10/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Moya
class Network {
    var getActorDelegate :GetActorsDelegate?
    var getImageDelegate : GetImageDelegate?
    var getAllImages: GetAllActorImages?
    let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    func getData(urlString : String , page_no: Int){
        let urlStr :String  = urlString+"&page="+"\(page_no)"
        Alamofire.request(urlStr, method: .get).responseData
            {  response in
                print(response)
                switch (response.result){
                case .success(_):
                    print("success")
                    if let result = response.result.value {
                         self.getActorDelegate!.receivingData(data: result)
                    }
                 case .failure(_):
                    print("fail")
                    self.getActorDelegate!.receivingData(data: nil)
                }
                
        }
    }
    
    
    func getImage(urlString: String, indexPath: IndexPath){
        let fullStr = "https://image.tmdb.org/t/p/original"+urlString
        
        let url = URL(string: fullStr)
        let task = URLSession.shared.dataTask(with: url!){ (data, resonse , error) in
            if error == nil {
              
                if self.getImageDelegate != nil {
                    self.getImageDelegate!.imageReceived(data: data, indexPath: indexPath)
                }

           }
        }
        task.resume()
    }
    
    func getActorImages(id: Int){
        provider.request(MultiTarget(MoyaService.allImages(id: id))) {result in
            switch result {
            case .success(let response):
                do {
                    print(try response.mapJSON())
                    if self.getAllImages != nil {
                        self.getAllImages!.imgurlReceived(data: try response.mapString())
                    }
                }catch {
                
                }
           case .failure(let error):
                print(error)
            }
        }
      }
}
