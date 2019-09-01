//
//  HomeTableViewController.swift
//  TheMovieDb
//
//  Created by Lost Star on 8/30/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
let baseURL = "https://api.themoviedb.org/3/person/popular?api_key=facd2bc8ee066628c8f78bbb7be41943&language=en-US&sort_by=popularity.desc"
    var persons : [Person] = []
    var page_no = 1
    var lastContentOffset: CGFloat = 0
    var indRow = 0
    var selectedPerson = Person()
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
       self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
  self.tableView.addSubview(refreshControl!) // not required when using UITableViewController
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        persons = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getData()
        }
       
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        if persons.count != 0 {
        indRow = indexPath.row
        cell.setCell(person: persons[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func getData(){
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
                                if self.refreshControl?.isRefreshing ?? false
                                {
                                    self.refreshControl?.endRefreshing()
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
   
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
        
            if persons.count != 0 {
               if indRow == (persons.count - 3) {
                    page_no += 1
                    getData()
           }
            }
        }
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
