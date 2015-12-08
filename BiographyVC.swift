//
//  BiographyVC.swift
//  AuditionCity
//
//  Created by Paul Vagner on 12/8/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class BiographyVC: UIViewController {

    @IBOutlet weak var biographyView: BioTextView!
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: 300, height: 275)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    // 
    
    var actor: [String:AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let bio = actor["bio"] as? String {
            
            biographyView.text = bio
            
        }
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
