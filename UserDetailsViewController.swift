//
//  UserDetailsViewController.swift
//  AuditionCity
//
//  Created by Paul Vagner on 11/22/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    
    @IBOutlet weak var faceShot: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var contactButton: Buttons!
    
    @IBOutlet weak var starmeButton: Buttons!
    
    @IBOutlet weak var skillSetView: UIScrollView!
    
    @IBOutlet weak var measurementsLabel: UILabel!
    
    @IBOutlet weak var resumeView: UIScrollView!
    
    @IBAction func contactButton(sender: Buttons) {
    
    }
    
    @IBAction func starmeButton(sender: Buttons) {
    
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
