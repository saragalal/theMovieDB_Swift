//
//  GetActors.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/10/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import Foundation

class Network {

    
    var getActorDelegate :GetActorsDelegate?
    var getImageDelegate : GetImageDelegate?
    var imageCallBack : ((Data) ->())?
    var getAllImages: GetAllActorImages?
    
func getData(urlString : String , page_no: Int){
    
    let urlStr :String  = urlString+"&page="+"\(page_no)"
    
    let url :URL = URL(string: urlStr)!
    
    let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
        do{
            if (data != nil){
                 if self.getActorDelegate != nil {
                 self.getActorDelegate!.receivingData(data: data!)
                }

            }
        }
      
        
    }
    task.resume()
    
}
    
    
    func getImage(urlString: String){
        
        let url = URL(string: "https://image.tmdb.org/t/p/original"+urlString)
        
        
        
        let task = URLSession.shared.dataTask(with: url!){ (data, resonse , error) in
            if error == nil {
              
                if self.getImageDelegate != nil {
                    self.getImageDelegate!.imageReceived(data: data)
                }

           }
            
        }
        task.resume()
    }
  
    func getActorImages(urlString: String,id: Int){
     
            let urlString = urlString+"\(id)"+"/images?api_key=facd2bc8ee066628c8f78bbb7be41943"
            
            let url :URL = URL(string: urlString)!
            
            let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
                do{
                    if (data != nil){
                        if self.getAllImages != nil {
                        self.getAllImages!.imgurlReceived(data: data!)
                        }

                }
              
                
            }
        }
            task.resume()
        }
    
    

    
}
