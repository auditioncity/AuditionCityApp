//
//  FavoritesTableVC.swift
//  AuditionCity
//
//  Created by Paul Vagner on 11/26/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class FavoritesTableVC: UITableViewController {

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = false
        
        // run request to rails to pull all actors
        
        
        
//        let rr = RailsRequest.session()
//        
//        var info = RequestInfo()
//        
//        info.endpoint = "actors"
//        info.method = .GET
//        
//        print(info)
//        
//        rr.requiredWithInfo(info) { (returnedInfo) -> () in
//            
//            print(returnedInfo)
//            
//            self.users = returnedInfo?["actors"] as? [[String:AnyObject]] ?? []
//            
//            self.tableView.reloadData()
//            
//        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    var users: [[String:AnyObject]] = []

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LogData.logSession().starred.count
    }

    
    
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            // #warning Incomplete implementation, return the number of rows
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier("favoriteCell", forIndexPath: indexPath) as! FavoriteCell
            
            guard let user = LogData.logSession().starred[indexPath.row]["actor"] as? [String:AnyObject] else { return cell }
            
            cell.userNameLabel.text = user["full_name"] as? String
            
            let dispatch = dispatch_queue_create("tableView", DISPATCH_QUEUE_SERIAL)
            
            if let faceShotURL = user["headshot_mobile"] as? String {
                
                cell.faceShot.hidden = false
                
                dispatch_async(dispatch) { () -> Void in
                    
                    if let url = NSURL(string: faceShotURL) {
                        
                        if let data = NSData(contentsOfURL: url) {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                if let image = UIImage(data:data) {
                                    
                                    cell.faceShot.image = image
                                    
                                }
                                
                            })
                        }
                    }
                    
                }
                
            } else {
                
                cell.faceShot.hidden = true
            }
            
            
            return cell
            
        }
    
    


    
}