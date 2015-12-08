//
//  UserDetailsViewController.swift
//  AuditionCity
//
//  Created by Paul Vagner on 11/22/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var actor: [String:AnyObject] = [:]
    
    @IBOutlet weak var faceShot: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var contactButton: Buttons!
    @IBOutlet weak var starmeButton: Buttons!
    @IBOutlet weak var skillSetView: UIScrollView!
    @IBOutlet weak var measurementsLabel: UILabel!
    @IBOutlet weak var resumeView: UIScrollView!
    @IBOutlet weak var expandResume: ToggleButton!
    @IBOutlet weak var resumePanelTop: NSLayoutConstraint!
    @IBAction func expandResumeTapped(sender: ToggleButton) {
    
        resumePanelTop.constant = resumePanelTop.constant == 0 ? -248 : 0
        view.setNeedsUpdateConstraints()
        
        let degrees: CGFloat = resumePanelTop.constant != 0 ? 180 : 0
        
        //animates the dropdown window.
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.view.layoutIfNeeded()
            //Animates the dropdown window /Toggle button.
            let degreesToRadians: (CGFloat) -> CGFloat = {
                return $0 / 180.0 * CGFloat(M_PI)
            }
            
            let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
            
            self.expandResume.transform = t
            
        }

    }
    
    @IBAction func contactButtonPressed(sender: Buttons) {
    
    }
    
    @IBAction func starmeButtonPressed(sender: Buttons) {
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        fullNameLabel.text = actor["full_name"] as? String
        
        if let ageY = actor["age_young"] as? Int, ageO = actor["age_old"] as? Int, let heightFT = actor["height_feet"] as? Int, heightIN = actor["height_inches"] as? Int {
                
            measurementsLabel.text = "Age: \(ageY) - \(ageO)" + "\nHeight: \(heightFT)ft, \(heightIN)in"
            
        }
        // layout everything on the detail view based on actor dictionary
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let popupView = segue.destinationViewController as? ContactVC {
            
            if let popup = popupView.popoverPresentationController
            {
                
                popup.delegate = self
            }
            
        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
    }

}
