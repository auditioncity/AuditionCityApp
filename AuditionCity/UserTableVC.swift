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
        
    }
    
    var users: [[String:AnyObject?]] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell

        let user = users[indexPath.row]
    
       if let username = user["login"] as? String {
            
            cell.userNameLabel.text = username
        }
        
        if let faceShotURL = user[RailsRequest] as? String{
            
            cell.faceShot.hidden = false
            
            if let url = NSURL(string: faceShotURL) {
                if let data = NSData(contentsOfURL: url) {
                    if let image = UIImage(data:data) {
                        cell.faceShot.image = image
                        
                    }
                }
            }
        } else {
            
            cell.faceShot.hidden = true
        }
        
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
