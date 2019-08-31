//
//  DetailsViewController.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/31/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    var baseUrl = "https://api.themoviedb.org/3/person/"
    var imagesUrl : [String] = []
    
    var person = Person()
    var imageView :UIImageView!
    var typeLb: UILabel!
    var typeName: UILabel!
    var overview: UITextView!
    
    var nameLb: UILabel!
    var profImage: UIImageView!
    var profile: UIImage!
    var selctedImage: UIImage!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        getImages()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  imagesUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath)
        
        //imageView = cell.viewWithTag(1) as? UIImageView
        
        if imagesUrl.count != 0 {
            
            let urlString = "https://image.tmdb.org/t/p/original"+imagesUrl[indexPath.row]
            
            let url :URL = URL(string: urlString)!
            
            let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
                
                if error == nil && data != nil{
                    let loadedImage = UIImage(data: data!)
                    DispatchQueue.main.async {
                        let thisCell = self.collectionView.cellForItem(at: indexPath)
                        
                        if (thisCell) != nil {
                           self.imageView = thisCell?.viewWithTag(1) as? UIImageView
                        self.imageView.image = loadedImage
                    }
                    }
                }
            }
            task.resume()
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let cell = self.collectionView.cellForItem(at: indexPath)
        
        let imgview = cell?.viewWithTag(1) as? UIImageView
        
        selctedImage = imgview?.image
        
        
        performSegue(withIdentifier: "saveSegue", sender: self)
    }
    
    @IBAction func slectProfile(_ sender: Any) {
        
        selctedImage = profile
        
        performSegue(withIdentifier: "saveSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue"{
            let vc = segue.destination as! PhotoVC
            
            vc.imageSave = selctedImage
            
        }
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
            
            nameLb = headerView.viewWithTag(2) as? UILabel
            profImage = headerView.viewWithTag(3) as? UIImageView
            typeLb = headerView.viewWithTag(4) as? UILabel
            typeName = headerView.viewWithTag(5) as?  UILabel
            overview = headerView.viewWithTag(6) as? UITextView
            
            nameLb!.text = person.name!
            
            if person.knowFor != [] {
                typeName!.text = person.knowFor[0]?.title
                typeLb!.text = person.knowFor[0]?.type
                overview!.text = person.knowFor[0]?.overview
            }
            
            if person.profile_path != nil {
                let urlString = "https://image.tmdb.org/t/p/w500"+person.profile_path!
                
                let url :URL = URL(string: urlString)!
                
                let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
                    
                    if error == nil && data != nil{
                        
                        self.profile =  UIImage(data: data!)
                        DispatchQueue.main.async {
                            self.profImage.image = self.profile
                        }
                        
                    }
                }
                task.resume()
            }
            // Customize headerView here
            return headerView
        }
        fatalError()
    }
    
    func getImages(){
        if person.id != nil {
            let urlString = baseUrl+"\(person.id!)"+"/images?api_key=facd2bc8ee066628c8f78bbb7be41943"
            
            let url :URL = URL(string: urlString)!
            
            let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
                do{
                    if (data != nil){
                        
                        let dic = try JSONSerialization.jsonObject(with: data! , options: []) as? NSDictionary
                        
                        print("dic resposne \(dic!)")
                        
                        let results = dic?["profiles"] as? [NSDictionary]
                        if results != nil {
                            for result in results! {
                                let str = result["file_path"] as? String
                                if str != nil {
                                    self.imagesUrl.append(str!)
                                    
                                }
                            }
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                            
                        }
                    }
                }
                catch {
                    print("json error \(error)")
                }
                
            }
            task.resume()
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
