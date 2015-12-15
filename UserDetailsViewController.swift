//
//  UserDetailsViewController.swift
//  AuditionCity
//
//  Created by Paul Vagner on 11/22/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit
import QuickLook

class UserDetailsViewController: UIViewController, UIPopoverPresentationControllerDelegate,  QLPreviewControllerDelegate, QLPreviewControllerDataSource {

    var actor: [String:AnyObject] {
        
        return LogData.logSession().users[index]["actor"] as? [String:AnyObject] ?? [:]
        
    }
    var index: Int!
    
    
    @IBAction func swipeBack(sender: UISwipeGestureRecognizer) {
    
        navigationController?.popViewControllerAnimated(true)
    }
    @IBOutlet weak var Bio: UIButton!
    @IBOutlet weak var faceShot: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var contactButton: Buttons!
    @IBOutlet weak var starmeButton: Buttons!
    @IBOutlet weak var skillSetView: UITextView!
    @IBOutlet weak var measurementsLabel: UILabel!
    @IBOutlet weak var resumeView: UIScrollView!
    @IBOutlet weak var resumeDownload: UIButton!
    
    @IBOutlet weak var expandResume: ToggleButton!
    @IBOutlet weak var resumePanelTop: NSLayoutConstraint!
    @IBAction func expandResumeTapped(sender: ToggleButton) {
    
        resumePanelTop.constant = resumePanelTop.constant == 0 ? -230 : 0
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
        
        if starmeButton.tag == 0 {
            
            starmeButton.tag = 1
            starmeButton.backgroundColor = UIColor(red:0.95, green:0.78, blue:0.86, alpha:1)
        
        } else {
            
            starmeButton.tag = 0
            starmeButton.backgroundColor = UIColor.lightGrayColor()
            
        }
        
        var updated = actor
        updated["decision_callback"] = starmeButton.tag
        LogData.logSession().users[index]["actor"] = updated
        
//        let isTrue: Bool = true
        var info = RequestInfo()
        
        info.endpoint = "decisions/new"
        
        info.method = .POST
        
        info.parameters = [
            
            "actor_id" : actor["id"] as? Int ?? 0,
            "callback" : starmeButton.tag == 1
            
        ]
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
         
            
            print("success")
            
        }
        
    }
    
    @IBAction func downloadResumeTapped(sender: UIButton) {
    
        if let resumeURL = NSURL(string: actor["resume"] as? String ?? "") {
            
            let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
            
            // your destination file url
            let destinationUrl = documentsUrl.URLByAppendingPathComponent(resumeURL.lastPathComponent!)
            
            if let tempDocRef = CGPDFDocumentCreateWithURL(destinationUrl) {
            
                let pageCount: size_t = CGPDFDocumentGetNumberOfPages(tempDocRef)
                
                print(pageCount)
                
                UIGraphicsBeginImageContext(CGSize(width: 850, height: 1100))
                let context = UIGraphicsGetCurrentContext()
                
                for var pageNum = 1; pageNum <= pageCount; pageNum++ {
                
                    if let tempPageRef = CGPDFDocumentGetPage(tempDocRef, pageNum) {
                    
                        CGPDFContextBeginPage(context, nil)
                        
                        CGContextDrawPDFPage(context, tempPageRef)
                    
                        if let newimage = UIGraphicsGetImageFromCurrentImageContext() {
                        
                            UIImageWriteToSavedPhotosAlbum(newimage, self, nil, nil)
                            print(newimage)
                            print("images created")
                            
                        }
                        
                    }
                
                }
                
                UIGraphicsEndImageContext()
                
            }
            
        }
        
    }
    
    var callback = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set image based on decision_callback being true
        if let decision = actor["decision_callback"] as? Int where decision == 1 {
            
            starmeButton.tag = 1
            starmeButton.backgroundColor = UIColor(red:0.95, green:0.78, blue:0.86, alpha:1)
            
        } else {
            
            starmeButton.tag = 0
            starmeButton.backgroundColor = UIColor.lightGrayColor()
            
        }
        
        self.navigationController?.navigationBarHidden = true
        
        //creates info and sets it to empty string
        var info = ""
        
        //runs fullNameLabel.text and sets the results -> actor<from API>and endpoint of ["full_name"] and converts the results into a Sting format.
        fullNameLabel.text = actor["full_name"] as? String
        
        //creates an if loop* for ageYoung and ageOld sets the results to appropriate locations on API and their respective endpoints
        if let ageY = actor["age_young"] as? Int, ageO = actor["age_old"] as? Int {
            //runs the empty String info and sets it to "Age: \(ageY) - \(ageO)"
            info += "Age: \(ageY) - \(ageO)"
        }
        
        if let heightFT = actor["height_feet"] as? Int {
            info += "\nHeight: \(heightFT)ft"
        }
        
        if let heightIN = actor["height_inches"] as? Int {
            info += " \(heightIN)in"
        }
        
        if let eyeColor = actor["eye_color"] as? String {
            info += "\nEyes: \(eyeColor)"
        }
        
        if let hairColor = actor["hair_color"] as? String {
            info += "\nHair: \(hairColor)"
        }
        
        skillSetView.textAlignment = .Natural
        skillSetView.text = actor["skills"] as? String
        measurementsLabel.text = info
        
        if let faceShotURL = actor["headshot_mobile"] as? String {
            
            if let url = NSURL(string: faceShotURL) {
                
                if let data = NSData(contentsOfURL: url) {
                    
                    if let image = UIImage(data:data) {
                     
                        faceShot.image = image
                    }
                }
            }
        
        } else {
            
        }
        
        self.addChildViewController(resumePreview)
        //*view controller containment
        //set the frame from the parent view
        
        let w = self.resumeView.frame.width
        
        let h = self.resumeView.frame.height
        
        resumePreview.view.frame = CGRectMake(0, 0, w, h)
        
        self.resumeView.addSubview(resumePreview.view)
        
        resumePreview.didMoveToParentViewController(self)
        //save a reference to the preview controller
        
        
        if let resumeURL = NSURL(string: actor["resume"] as? String ?? "") {
            // create your document folder url
            
            let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
            // your destination file url
            
            let destinationUrl = documentsUrl.URLByAppendingPathComponent(resumeURL.lastPathComponent!)
            
            if let myResumeFromUrl = NSData(contentsOfURL: resumeURL){
                    // after downloading your data you need to save it to your destination url
                   
                    if myResumeFromUrl.writeToURL(destinationUrl, atomically: true) {
                        
                        print("file saved")
                        
                        resumePreview.dataSource = self
                        
                        resumePreview.delegate = self
                        
                        resumePreview.reloadData()
                    
                    } else {
                    
                        print("error saving file")
                    }
                }

        }
        
    }

    
    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController) -> Int {
        
        return actor["resume"] == nil ? 0 : 1
        
    }
    
    func previewController(controller: QLPreviewController, previewItemAtIndex index: Int) -> QLPreviewItem {
        
        var destinationUrl: NSURL?

        if let resumeURL = NSURL(string: actor["resume"] as? String ?? "") {
            // create your document folder url
            
            let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
            // your destination file url
            
            destinationUrl = documentsUrl.URLByAppendingPathComponent(resumeURL.lastPathComponent!)

        }

        return destinationUrl!
        
    }
    
    
    var resumePreview: QLPreviewController = QLPreviewController()
    
    
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
            
            popupView.index = index
            
            if let popup = popupView.popoverPresentationController
            {
                
                popup.delegate = self
            }
            
        }
        
        
        if let popupView = segue.destinationViewController as? BiographyVC {
            
            popupView.actor = actor
            
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
