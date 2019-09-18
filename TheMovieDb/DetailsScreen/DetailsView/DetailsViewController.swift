//
//  DetailsViewController.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/31/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, DetailsViewProtocol {
   
    @IBOutlet weak var collectionView: UICollectionView!
    var detailsPresenter: DetailsPresenterProtocol?
    
    var baseUrl = "https://api.themoviedb.org/3/person/"
    var imagesUrl : [String] = []
    
    var selctedImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //getImages()
        //getImages()
        detailsPresenter?.detailsInit()
//        if (person.id != nil) {
//            person.requestAllImage(imgUrl: baseUrl, id: person.id! ,completion:{ urlArray in
//                if urlArray != nil {
//                    self.imagesUrl = urlArray!
//                    print("urls   ",urlArray!)
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData()
//                    }
//                }
//
//            })
//        }
        
      
    }
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let number = detailsPresenter?.getCollectionImagesCount(){
             return number
        }
          return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as? DetailsCollectionViewCell
        if let imgurl = (detailsPresenter?.getImageUrlForItem(at: indexPath.row)){
        cell?.setImageCell(urlStr: imgurl)
       }
        return cell!
    }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailsPresenter?.cellSelected(at: indexPath.row)
//       let cell = self.collectionView.cellForItem(at: indexPath)
//
//        let imgview = cell?.viewWithTag(1) as? UIImageView
//
//        selctedImage = imgview?.image
//        performSegue(withIdentifier: "saveSegue", sender: self)
    }
    
    @IBAction func slectProfile(_ sender: Any) {
        detailsPresenter?.profileImageIsSelected()
       // selctedImage = profile
        
       // performSegue(withIdentifier: "saveSegue", sender: self)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "saveSegue"{
//            let navcontroller = segue.destination as! UINavigationController
//            let vc = navcontroller.topViewController as! PhotoVC
//
//            vc.imageSave = selctedImage
//
//        }
//    }
   
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as? DetailsCollectionReusableView
            if let actor = detailsPresenter?.getCurrentActor(){
                if headerView != nil {
                    // headerView?.setProfImage(img: profile)
                    headerView?.setView(actor: actor)
                }
            }
            return headerView!
        }
        fatalError()
    }
    
    func instatiatePhotoView() -> SavePhotoViewContoller? {
        let storyboard = UIStoryboard(name: "Details_Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SavePhotoViewController") as? SavePhotoViewContoller
        return vc
    }
    func navigateToPhotoScreen(photoView: SavePhotoViewContoller){
        self.navigationController?.pushViewController(photoView, animated: true)
    }

  
    
}
