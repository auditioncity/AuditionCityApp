/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A custom check box used in the lists. It supports designing live in Interface Builder.
*/

import UIKit

@IBDesignable public class CheckBox: UIControl {
    // MARK: Properties
    
    public override func drawRect(rect: CGRect) {
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    
    @IBInspectable public var isChecked: Bool {
        get {
            return checkBoxLayer.isChecked
        }
        
        set {
            checkBoxLayer.isChecked = newValue
        }
    }

    @IBInspectable public var strokeFactor: CGFloat {
        set {
            checkBoxLayer.strokeFactor = newValue
        }

        get {
            return checkBoxLayer.strokeFactor
        }
    }
    
    @IBInspectable public var insetFactor: CGFloat {
        set {
            checkBoxLayer.insetFactor = newValue
        }

        get {
            return checkBoxLayer.insetFactor
        }
    }
    
    @IBInspectable public var markInsetFactor: CGFloat {
        set {
            checkBoxLayer.markInsetFactor = newValue
        }
    
        get {
            return checkBoxLayer.markInsetFactor
        }
    }
    
    // MARK: Overrides
    
    override public func didMoveToWindow() {
        if let window = window {
            contentScaleFactor = window.screen.scale
        }
    }
    
    public override func didMoveToSuperview() {
        setNeedsDisplay()
        print(isChecked)
    }

    override public class func layerClass() -> AnyClass {
        return CheckBoxLayer.self
    }
    
    override public func tintColorDidChange() {
        super.tintColorDidChange()
        
        checkBoxLayer.tintColor = tintColor.CGColor
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        isChecked = !isChecked
        print(isChecked)
        
    }

    // MARK: Convenience
    
    var checkBoxLayer: CheckBoxLayer {
        return layer as! CheckBoxLayer
    }
}
