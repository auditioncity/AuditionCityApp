//
//  FavoritesVC.swift
//  AuditionCity
//
//  Created by Paul Vagner on 11/26/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
    
    dismissViewControllerAnimated(true, completion: nil)
    
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
