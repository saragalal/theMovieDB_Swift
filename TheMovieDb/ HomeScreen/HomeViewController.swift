//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/10/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource , UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    let baseURL = "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc"
    var searchUrl = "https://api.themoviedb.org/3/search/person?api_key=facd2bc8ee066628c8f78bbb7be41943&query="
    var persons : [Person] = []
    var page_no = 1
    var lastContentOffset: CGFloat = 0
    var indRow = 0
    var selectedPerson = Person()
    var searchISPressed = false
    var searchResults : [Person] = []
    var searchWasDone = false
    var imgProfile = UIImage()
    
    var actorsModel = Actors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
  
       tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(self.tableView.refreshControl!) // not required when using UITableViewController
    }
    override func viewWillAppear(_ animated: Bool) {
   
        sendRequest(urlstring: baseURL, no_page: page_no)
    }
    
    
    func sendRequest(urlstring: String,no_page : Int) {
        actorsModel.requestActorArray(urlStr: urlstring, page: no_page, complation: { result in
            print("result" ,result!)
            if result != nil {
                self.persons = result!.actors
                DispatchQueue.main.async {
                    if self.tableView.refreshControl?.isRefreshing ?? false
                                {
                                    self.tableView.refreshControl?.endRefreshing()
                                }
                    
                    self.tableView.reloadData()
                }
            }
            
        })

        
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        URLCache.shared.removeAllCachedResponses()
        persons = []
        
        searchISPressed = false
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        searchBar.text = ""
        
        
        self.tableView.reloadData()
        self.page_no = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
 
             self.sendRequest(urlstring: self.baseURL, no_page: self.page_no)
        }
    }
    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search bar has been clicked")
        searchISPressed = true
        searchWasDone = true
        let searchKey = searchBar.text
        print(searchKey!)
        searchBar.setShowsCancelButton(true, animated: false)
        searchBar.resignFirstResponder()
        if let cancelButton : UIButton = searchBar.value(forKey: "_cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
        
        if searchKey != nil , searchKey != "" {
            searchUrl += searchKey!

             sendRequest(urlstring: searchUrl, no_page: page_no)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel was selected")
        
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        searchISPressed = false
        
        searchBar.text = ""
        self.page_no = 1
        persons = []
       
       sendRequest(urlstring: baseURL, no_page: page_no)
        self.tableView.reloadData()
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.persons = []
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchBar.becomeFirstResponder()
        print("search bar has changed")
        URLCache.shared.removeAllCachedResponses()
        searchBar.showsCancelButton = true
        persons.removeAll()
        self.tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        if persons.count != 0 {
            indRow = indexPath.row
            cell.setCell(person: persons[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPerson = persons[indexPath.row]

        print("array", persons[indexPath.row].knowFor)
        performSegue(withIdentifier: "detSegue", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detSegue"{
            let nav = segue.destination as! UINavigationController
            let vc = nav.topViewController as! DetailsViewController
            
            vc.person = selectedPerson
           
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            
            if persons.count != 0 {
                if indRow == (persons.count - 3) {
                    
                    if searchISPressed  {
                        if page_no < 500{
                            page_no += 1
                       
                            sendRequest(urlstring: searchUrl, no_page: page_no)
                        }
                    } else {
                        if page_no < 467 {
                            page_no += 1
                       
                            sendRequest(urlstring: baseURL, no_page: page_no)
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
}
