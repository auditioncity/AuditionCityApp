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

    var actor: [String:AnyObject] = [:]
    
    @IBOutlet weak var Bio: UIButton!
    @IBOutlet weak var faceShot: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var contactButton: Buttons!
    @IBOutlet weak var starmeButton: Buttons!
    @IBOutlet weak var skillSetView: UIScrollView!
    @IBOutlet weak var measurementsLabel: UILabel!
    @IBOutlet weak var resumeView: UIScrollView!
    @IBOutlet weak var resumeDownload: UIButton!
    
    @IBOutlet weak var expandResume: ToggleButton!
    @IBOutlet weak var resumePanelTop: NSLayoutConstraint!
    @IBAction func expandResumeTapped(sender: ToggleButton) {
    
        resumePanelTop.constant = resumePanelTop.constant == 0 ? -235 : 0
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
                
//                let finalPdfContext = CGPDFContextCreateWithURL(destinationUrl, nil, nil)
                
                for var pageNum = 1; pageNum <= pageCount; pageNum++ {
                
                    if let tempPageRef = CGPDFDocumentGetPage(tempDocRef, pageNum) {
                    
                        CGPDFContextBeginPage(context, nil)
                        
                        CGContextDrawPDFPage(context, tempPageRef)
                    
                        if let newimage = UIGraphicsGetImageFromCurrentImageContext() {
                        
                            UIImageWriteToSavedPhotosAlbum(newimage, self, nil, nil)
                            
                            print("images created")
                            
                        }
                        
                    }
                
                }
                
                UIGraphicsEndImageContext()
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var info = ""


        fullNameLabel.text = actor["full_name"] as? String
        
        if let ageY = actor["age_young"] as? Int, ageO = actor["age_old"] as? Int {
            
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
        //save a reference to the preview controller in an ivar
        
        
        if let resumeURL = NSURL(string: actor["resume"] as? String ?? "") {
            // create your document folder url
            
            let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
            // your destination file url
            
            let destinationUrl = documentsUrl.URLByAppendingPathComponent(resumeURL.lastPathComponent!)
            
            
            // check if it exists before downloading it
            
//            if NSFileManager().fileExistsAtPath(destinationUrl.path!) {
////                print("The file already exists at path")
//                
//                
//                resumePreview.dataSource = self
//                
//                resumePreview.delegate = self
//                
//                resumePreview.reloadData()
//            
//            } else {
//                //  if the file doesn't exist
//                //  just download the data from your url
            
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
//            }
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
