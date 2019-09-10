//
//  DetailsViewController.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/31/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //getImages()
        //getImages()
        if (person.id != nil) {
            person.requestAllImage(imgUrl: baseUrl, id: person.id! ,completion:{ urlArray in
                if urlArray != nil {
                    self.imagesUrl = urlArray!
                    print("urls   ",urlArray!)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            })
        }
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  imagesUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath)
        
        imageView = cell.viewWithTag(1) as? UIImageView
        
        if imagesUrl.count != 0 {
           
           
         let urlString = imagesUrl[indexPath.row]
            
             getCellImage(url: urlString, indexPath: indexPath)

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
            let navcontroller = segue.destination as! UINavigationController
            let vc = navcontroller.topViewController as! PhotoVC
            
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
            
            
            profImage.layer.masksToBounds = false
            
            profImage.layer.cornerRadius = 10
            profImage.clipsToBounds = true
            nameLb!.text = person.name!
            
            if person.knowFor != [] {
                typeName!.text = person.knowFor[0]?.title
                typeLb!.text = person.knowFor[0]?.type
                overview!.text = person.knowFor[0]?.overview
            } else {
                typeName!.text = "no data"
                typeLb!.text = "no data"
                overview!.text = "no available data"
            }
            
            if person.profile_path != nil {
                let urlString = person.profile_path!
                
               // let url :URL = URL(string: urlString)!
                //getCellImage(url: urlString, indexPath: indexPath)
                
                person.requestImage(imgUrl: urlString, completion: {data in
                    
                    let loadedImage = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self.profImage.image = loadedImage
                    }
                })


            }
           
            return headerView
        }
        fatalError()
    }
    

    
    func getCellImage(url : String , indexPath: IndexPath){
       

        person.requestImage(imgUrl: url, completion: {data in
            
            let loadedImage = UIImage(data: data!)
            DispatchQueue.main.async {
                let thisCell = self.collectionView.cellForItem(at: indexPath)
                
                if (thisCell) != nil {
                    self.imageView = thisCell?.viewWithTag(1) as? UIImageView
                    self.imageView.layer.masksToBounds = false
                    
                    self.imageView.layer.cornerRadius = 5
                    self.imageView.clipsToBounds = true
                    self.imageView.image = loadedImage
                }
                
               
            }
        })
        
        
        
    }
    
  
    
}
