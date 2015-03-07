//
//  AddInsultViewController.swift
//  Comebacker
//
//  Created by Ray Lin on 3/7/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

import UIKit

class AddInsultViewController: UIViewController {

    @IBOutlet weak var addInsultTextField: UITextField!
    
    
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        var escapedString = addInsultTextField.text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        var url = NSURL(string: "http://localhost:3000/insults/create?text=\(escapedString!)")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            println(data)
            println(response)
            println(error)
        })
        task.resume()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
