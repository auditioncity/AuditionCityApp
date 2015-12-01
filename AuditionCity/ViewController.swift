import UIKit

class ViewController: UIViewController {
    let rangeSlider = RangeSlider(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rangeSlider)
        
        rangeSlider.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.rangeSlider.trackHighlightTintColor = UIColor.redColor()
            self.rangeSlider.curvaceousness = 0.0
        }
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
            width: width, height: 31.0)
    }
    
    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: (\(rangeSlider.lowerValue) \(rangeSlider.upperValue))")
    }
}