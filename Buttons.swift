//
//  Buttons.swift
//  AuditionCity
//
//  Created by Paul Vagner on 11/20/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

@IBDesignable class Buttons: UIButton {

       override func drawRect(rect: CGRect) {
    
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.masksToBounds = true
        
    }
   
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0
    
    @IBInspectable var borderColor: CGColor = UIColor.blackColor().CGColor
    
    }

@IBDesignable class Buttons2: UIButton {
    
    override func drawRect(rect: CGRect) {
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.masksToBounds = true
        
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0
    
    @IBInspectable var borderColor: CGColor = UIColor.whiteColor().CGColor
    
}