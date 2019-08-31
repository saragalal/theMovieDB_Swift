//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/29/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0)  {
           self.performSegue(withIdentifier: "homeSegue", sender: self)
        }
        
        
    }
//    
//    func getData(){
//        let urlString :String  = "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc"
//       
//        let url :URL = URL(string: urlString)!
//        
//        let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
//     do{
//        if (data != nil){
//      
//             let resp = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments)
//            print("first resposne \(resp)")
//            let dic = try JSONSerialization.jsonObject(with: data! , options: []) as? NSDictionary
//            
//            print("dic resposne \(dic!)")
//            
//            let result = dic?["results"] as? [NSDictionary]
//        print("result\(result!)")
//     }
//     }
//     catch {
//        print("json error \(error)")
//        }
//        
//        }
// task.resume()
//        
//    }

}

