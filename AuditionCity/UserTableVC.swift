//
//  UserTableVC.swift
//  AuditionCity
//
//  Created by Paul Vagner on 11/23/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class UserTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBarHidden = false
        
        // run request to rails to pull all actors
        
        
        
        let rr = RailsRequest.session()
        
        var info = RequestInfo()
        
        info.endpoint = "actors"
        info.method = .GET
        
        print(info)
        
        rr.requiredWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            LogData.logSession().users = returnedInfo?["actors"] as? [[String:AnyObject]] ?? []
            
            self.tableView.reloadData()
            
        }
    }
    
    var users: [[String:AnyObject]] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return LogData.logSession().users.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        
        guard let user = LogData.logSession().users[indexPath.row]["actor"] as? [String:AnyObject] else { return cell }
        
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
    
      // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Detail" {
            
            guard let cell = sender as? UserCell else { return }
            guard let indexPath = tableView.indexPathForCell(cell) else { return }
//            guard let user = LogData.logSession().users[indexPath.row]["actor"] as? [String:AnyObject] else { return }
            
            let detailVC = segue.destinationViewController as? UserDetailsViewController
            
            detailVC?.index = indexPath.row
//            detailVC?.actor = user
            
        }
        
        
        
        
    }
    
}
