//
//  ContactVC.swift
//  AuditionCity
//
//  Created by Paul Vagner on 12/1/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: 300, height: 140)
        }
        set {
            super.preferredContentSize = newValue
        }
    }

       
    @IBOutlet weak var eMailButton: Buttons!
    @IBOutlet weak var callButton: Buttons!
    @IBOutlet weak var cancelButton: Buttons!
    
    @IBAction func cancelButtonTapped(sender: Buttons) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    @IBAction func eMailButtonTapped(sender: Buttons) {
    
    
    }
    
    @IBAction func callButtonTapped(sender: Buttons) {
    
    
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
