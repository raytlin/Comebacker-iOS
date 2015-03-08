//
//  ComebackTableViewController.swift
//  Comebacker
//
//  Created by Ray Lin on 3/7/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

import UIKit

class ComebackTableViewController: UITableViewController {

    var comebackJSONArray :NSArray = []
    var insult : NSDictionary?
    
    @IBOutlet var comebackTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if insult != nil {
            var id = insult!["id"] as Int
            var url = NSURL(string: "http://localhost:3000/insults/getComebacksForInsultID/\(String(id))")!
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                
                if data.length > 0  {
                    var jsondata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSArray
                    dispatch_sync(dispatch_get_main_queue(), {()-> Void in
                        self.comebackJSONArray = jsondata
                        self.comebackTableView.reloadData()
                    })
                }
            })
            task.resume()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return comebackJSONArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("comebackCell", forIndexPath: indexPath) as UITableViewCell
        
        var cellData = comebackJSONArray[indexPath.row] as NSDictionary
        cell.textLabel?.text = cellData["text"] as NSString
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var refreshButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButton") //Use a selector
        navigationItem.rightBarButtonItem = refreshButton
 
    }
    
    func addButton() {
        self.performSegueWithIdentifier("showComeback", sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showComeback"{
            var addComebackViewController = segue.destinationViewController as AddComebackViewController
            addComebackViewController.insult = self.insult
        }
    }
    

}
