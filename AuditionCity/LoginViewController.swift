////
////  LoginViewController.swift
////  login
////
////  Created by Susanne Burnham on 10/15/15.
////  Copyright © 2015 Anjel Villafranco. All rights reserved.
//
//import UIKit
//
//
//class LoginViewController: UIViewController {
//    
//    
//    @IBAction func cancelButton(sender: UIButton) {
//        
//        
//        self.navigationController?.popViewControllerAnimated(true)
//        
//        print("N")
//        
//    }
//    
//    
//    @IBOutlet weak var usernameField: UITextField!
//    
//    @IBOutlet weak var emailField: UITextField!
//    
//    @IBOutlet weak var passwordField: UITextField!
//    
//    @IBAction func pressedLogin(sender: AnyObject) {
//        
//        let usernameRequest = RailsRequest.session()
//        
//        guard let username = usernameField.text where !username.isEmpty else { return }
//        guard let password = passwordField.text where !password.isEmpty else { return }
//        
//        
//        
//        usernameRequest.loginWithUsername(username, andPassword: password, completion: { loggedIn in
//            
//            if loggedIn {
//                
//                let mainSB = UIStoryboard(name: "Main", bundle: nil)
//                
//                let LoginVC = mainSB.instantiateViewControllerWithIdentifier("UserTableVC") as?
//                CaptureViewController
//                
//                self.navigationController?.presentViewController(LoginVC!, animated: true, completion: nil)
//                
//                
//                
//            } else {
//                
//                
//                //
//                
//            }
//        })
//        
//    }
//    
//    
//    @IBAction func pressedRegister(sender: AnyObject) {
//        
//        let usernameRequest = RailsRequest.session()
//        
//        guard let username = usernameField.text where !username.isEmpty else { return }
//        guard let emailField = emailField.text where !emailField.isEmpty else { return }
//        guard let password = passwordField.text where !password.isEmpty else { return }
//        
//        
//        usernameRequest.registerWithUsername(username, andPassword: password, email: emailField, completion: { registered in
//            
//            if registered {
//                
//                let mainSB = UIStoryboard(name: "Main", bundle: nil)
//                
//                let LoginVC = mainSB.instantiateViewControllerWithIdentifier("imagePicker") as?
//                CaptureViewController
//                
//                self.navigationController?.presentViewController(LoginVC!, animated: true, completion: nil)
//                
//            } else {
//                
//                
//                //
//                
//            }
//            
//            
//        } )
//        
//    }
//    
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        let mainSB = UIStoryboard(name: "Main", bundle: nil)
//        
//        let LoginVC = mainSB.instantiateViewControllerWithIdentifier("imagePicker") as?
//        CaptureViewController
//        
//        self.navigationController?.presentViewController(LoginVC!, animated: true, completion: nil)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:
//            UIKeyboardWillShowNotification, object: nil);
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
//        
//    }
//    
//    func keyboardWillShow(sender: NSNotification) {
//        
//        self.view.frame.origin.y = -150
//        
//    }
//    
//    func keyboardWillHide(sender: NSNotification) {
//        
//        self.view.frame.origin.y = 0
//        
//    }
//    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
//    {
//        textField.resignFirstResponder()
//        return true;
//    }
//    
//}
//
//
