//
//  MainViewController.swift
//  Comebacker
//
//  Created by Ray Lin on 3/2/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    var searchController : UISearchController!
    
    var jsonDataArray : NSArray = []
    var suggestedJSONDataArray : NSArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        // self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0)
        self.mainTableView.tableHeaderView = self.searchController.searchBar
        self.searchController.delegate = self
        self.definesPresentationContext = true
      
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var url = NSURL(string: "http://localhost:3000/insults/getLimitedTo?limit=20")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            
            if data.length > 0  {
                var jsondata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSArray
                dispatch_sync(dispatch_get_main_queue(), {()-> Void in
                    self.jsonDataArray = jsondata
                    self.mainTableView.reloadData()
                })
            }
        })
        task.resume()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var label = UILabel()
        label.text = "Insults"
        label.backgroundColor = UIColor.lightGrayColor()
        return label
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if self.searchController.active {
            count = suggestedJSONDataArray.count
        }
        else {
            count = jsonDataArray.count
        }
        
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = mainTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        if self.searchController.active {
            var cellData = suggestedJSONDataArray[indexPath.row] as NSDictionary
            cell.textLabel?.text = cellData["text"] as NSString
        }
        else{
            var cellData = jsonDataArray[indexPath.row] as NSDictionary
            cell.textLabel?.text = cellData["text"] as NSString
        }
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        var searchString : String
        searchString = searchController.searchBar.text
        self.suggestedJSONDataArray = jsonDataArray.filteredArrayUsingPredicate(NSPredicate(format: "text contains[cd] %@", searchString)!)
        self.mainTableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
