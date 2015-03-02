//
//  MainViewController.swift
//  Comebacker
//
//  Created by Ray Lin on 3/2/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var url = NSURL(string: "http://localhost:3000/insults")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            
            if data.length > 0  {
                var jsondata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSArray
                dispatch_sync(dispatch_get_main_queue(), {()-> Void in
                    for entry in jsondata {
                        var e = entry as NSDictionary
                        self.mainTextView.text = self.mainTextView.text.stringByAppendingString(e["text"] as NSString)
                    }
                    
                })
            }
            
            
        })
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
