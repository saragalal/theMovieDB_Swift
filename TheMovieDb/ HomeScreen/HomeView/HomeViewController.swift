//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/10/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource , UISearchBarDelegate ,HomeViewProtocol{
    
  
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    let baseURL = "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc"
    
    var searchUrl = "https://api.themoviedb.org/3/search/person?api_key=facd2bc8ee066628c8f78bbb7be41943&query="
    var searchWasDone = false
    var imgProfile: UIImage?
    var searchKey :String? = ""
 
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = "HomeTableViewIdentifier"
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.accessibilityIdentifier = "refresh_control_label"
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(self.tableView.refreshControl!) // not required when using UITableViewController
        self.presenter = HomePresenterImplementaion(viewProtocol: self, modelProtocol: HomeModel())
        presenter?.viewIsReady()
    }
    

    @objc func refresh(sender:AnyObject) {
        URLCache.shared.removeAllCachedResponses()
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        searchBar.text = ""
        self.presenter?.refeshList()
  }
    
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchWasDone = true
        searchKey = searchBar.text
        print(searchKey!)
        searchBar.setShowsCancelButton(true, animated: false)
        searchBar.resignFirstResponder()
        if let cancelButton : UIButton = searchBar.value(forKey: "_cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
        if searchKey != nil , searchKey != "" {
           presenter?.searchIsPressed(text: searchKey!)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        searchBar.text = ""
       presenter?.cancelSearchButtonIsPressed()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.removeDataFromTableView()
     }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        presenter?.removeDataFromTableView()
    }
   
    func updateTableView() {
        DispatchQueue.main.async {
            if self.tableView.refreshControl?.isRefreshing ?? false
            {
                self.tableView.refreshControl?.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return presenter?.getSectionNumber() ?? 0
   }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.getActorsListCount() ?? 0
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
     //cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = "myCell_\(indexPath.row)"
       cell.setCell(actor: (presenter?.getCellContaint(at: indexPath.row))!, indexPath: indexPath, tableview: self.tableView)
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.cellISSelected(at: indexPath.row)
}


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom == height - 5 {
            print(" you reached end of the table")
             presenter?.loadNextPage()
        }
    }
   
    func instatiateDetailsView() -> DetailsViewController? {
        let storyboard = UIStoryboard(name: "Details_Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        return vc
     }
    func naviagteToDetails(detailsView: DetailsViewController){
        self.navigationController?.pushViewController(detailsView, animated: true)
    }
}
