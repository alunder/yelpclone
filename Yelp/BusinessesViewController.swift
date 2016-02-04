//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{

    var businesses: [Business]!
    var businessesBackup:  [Business]!
    var searchBar: UISearchBar!
    var categories: [Business] = []
    let refreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        

        Business.searchWithTerm("French", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
//
//Example of Yelp search with more search options specified
        
        
//        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            
//
//            
//            for business in businesses {
//                print(business.name!)
//                print(business.address!)
//            }
//            self.tableView.reloadData()
//
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        print("refresh function")
    }

    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(businessesBackup == nil) {
            businessesBackup = businesses
        }
        
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            businesses = businessesBackup
        } else {
            
            businesses = businesses.filter({(dataItem: Business) -> Bool in
                
             
                if dataItem.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
    }
        tableView.reloadData()
        
        

  
    
 
          }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    

    
    
//    Refresh Control Unfinished
//    func refreshControlAction(refreshControl: UIRefreshControl) {
//
//        // ... Create the NSURLRequest (myRequest) ...
//        
//        // Configure session so that completion handler is executed on main UI thread
//        let session = NSURLSession(
//            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
//            delegate:nil,
//            delegateQueue:NSOperationQueue.mainQueue()
//        )
//        
//        let task : NSURLSessionDataTask = session.dataTaskWithRequest(myRequest,
//            completionHandler: { (data, response, error) in
//                
//    
//                self.myTableView.reloadData()
//                
//                refreshControl.endRefreshing()
//        });
//        task.resume()
//    }

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
