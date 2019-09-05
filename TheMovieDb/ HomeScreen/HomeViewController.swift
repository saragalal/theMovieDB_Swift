//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by sara.galal on 9/5/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate , UITableViewDataSource ,UISearchBarDelegate {
    
     let searchBar = UISearchBar()

     @IBOutlet weak var tableView: UITableView!
    
    let baseURL = "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc"
    let searchURL = "https://api.themoviedb.org/3/search/person?api_key=facd2bc8ee066628c8f78bbb7be41943&query="
    var persons : [Person] = []
    var page_no = 1
    var lastContentOffset: CGFloat = 0
    var indRow = 0
    var selectedPerson = Person()
    var isPressed: Bool = false
    var searchText:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.dataSource = self
        self.tableView.delegate = self
       //self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.isPressed = false
      
        
        getData(baseURL: self.baseURL)
        
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        self.tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(self.tableView.refreshControl!) // not required when using UITableViewController
     
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        URLCache.shared.removeAllCachedResponses()
        persons = []
        hideSearchBar()
        self.tableView.reloadData()
        self.page_no = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getData(baseURL: self.baseURL)
        }
   }
    
   
     @IBAction func searchFunc (_ sender: Any) {
        if isPressed == false {
            isPressed = true
        createSearchBar()
        setGestures()
        } else if isPressed == true {
            hideKeyboard()
            hideSearchBar()
            
            isPressed = false
        }
        
    }
    
    func setGestures(){
        
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        keyboardTap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(keyboardTap)
        
    }
    
    func createSearchBar(){
        self.searchBar.isHidden = false
        self.searchBar.showsCancelButton = false
        searchBar.placeholder = "Search Person"
        self.searchBar.becomeFirstResponder()
        searchBar.delegate = self
        self.searchBar.tintColor = UIColor.lightGray
        self.navigationItem.titleView = searchBar
        
        self.view.endEditing(false)
    }
    
    @objc func hideKeyboard(){
        print("hideKeyboard")
   searchBar.resignFirstResponder()
   self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange")
        persons = []
      self.tableView.reloadData()
        self.searchText = searchText
     
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        self.searchBar.endEditing(true)
        if searchText != nil {
        getData(baseURL: searchURL+""+searchText!)
        }
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       persons = []
        self.tableView.reloadData()
       
        print("searchBarTextDidBeginEditing")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.persons = []
        self.tableView.reloadData()
    }
  
    
    func hideSearchBar() {
        navigationItem.titleView = nil
        self.persons = []
        self.tableView.reloadData()
        getData(baseURL: baseURL)
      
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
        view.endEditing(true)
        performSegue(withIdentifier: "detSegue", sender: self)

    }
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "detSegue"{
            let nav = segue.destination as! UINavigationController
            let vc = nav.topViewController as! DetailsViewController

            vc.person = selectedPerson

        }
    }
    
    func getData(baseURL: String){
        let urlString :String  = baseURL+"&page="+"\(page_no)"
        
        let url :URL = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) {(data ,response ,error) in
            do{
                if (data != nil){
                    
                    let dic = try JSONSerialization.jsonObject(with: data! , options: []) as? NSDictionary
                    print("dic resposne \(dic!)")
                    if dic != nil {
                        let results = dic?["results"] as? [NSDictionary]
                        
                        if (results != nil){
                            for result in results!{
                                let person = Person()
                                person.initWithDictionary(dict: result)
                                let works = result["known_for"] as? [NSDictionary]
                                
                                for work in works ?? [] {
                                    let w = Works()
                                    w.initWithDictionary(dict: work)
                                    person.knowFor.append(w)
                                }
                                
                                self.persons.append(person)
                            }
                            DispatchQueue.main.async {
                                if self.tableView.refreshControl?.isRefreshing ?? false
                                {
                                    self.tableView.refreshControl?.endRefreshing()
                                }
                                
                                self.tableView.reloadData()
                            }
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
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            
            if persons.count != 0 {
                if indRow == (persons.count - 3) {
                    page_no += 1
                    if isPressed  {
                        getData(baseURL: self.searchURL)
                    } else {
                        getData(baseURL: self.baseURL)
                    }
                }
            }
        }
    }
    
    
  
}
