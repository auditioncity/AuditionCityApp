////  LoginViewController.swift
////  login
////  Created by Paul Vagner on 10/15/15.
////  Copyright © 2015 Paul Vagner. All rights reserved.

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func pressedLogin(sender: AnyObject) {
        
        let usernameRequest = RailsRequest.session()
        
        guard let username = usernameField.text where !username.isEmpty else { return }
        guard let password = passwordField.text where !password.isEmpty else { return }
        
        
        
        usernameRequest.loginWithUsername(username, andPassword: password, completion: { loggedIn in
            
            if loggedIn {
                
                let mainSB = UIStoryboard(name: "Main", bundle: nil)
                
                let LoginVC = mainSB.instantiateViewControllerWithIdentifier("UserTableVC") as?
                UserTableVC
                
                self.navigationController?.viewControllers = [LoginVC!]
                
                print(loggedIn)
                
            } else {
                
                
                //
                
            }
        })
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if RailsRequest.session().token != nil {
            
                    let mainSB = UIStoryboard(name: "Main", bundle: nil)
            
                    let LoginVC = mainSB.instantiateViewControllerWithIdentifier("UserTableVC") as?
                    UserTableVC
            
                    self.navigationController?.viewControllers = [LoginVC!]
            
        }
        

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:
            UIKeyboardWillShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        self.view.frame.origin.y = -150
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        
        self.view.frame.origin.y = 0
        
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
}


