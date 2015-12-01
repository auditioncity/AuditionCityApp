import UIKit

class SearchVC: UIViewController, UIPopoverPresentationControllerDelegate {
   
    @IBOutlet weak var nameSearchField: UITextField!
    
    @IBOutlet weak var ageFrom: UILabel!
    
    @IBOutlet weak var ageTo: UILabel!
    
    @IBOutlet weak var ageRange: RangeSlider!
    
    @IBAction func ageRangePicked(sender: RangeSlider) {
        
        print(sender)
        
        let lowerValue = Int(sender.lowerValue)
        let upperValue = Int(sender.upperValue) 
        
        ageFrom.text = "\(lowerValue)"
        ageTo.text = "\(upperValue)"

   }
   
    @IBOutlet weak var talentAgencyTF: UITextField!
    
    
    @IBOutlet weak var unionTF: UITextField!
    
    
    @IBOutlet weak var okButton: UIButton!
    
    
    @IBAction func okButtonTapped(segue: UIStoryboardSegue) {
    
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
   
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    
    
    
    
    let picker = UIImageView(image: UIImage(named: "picker"))
    
    func openPicker()
    {
        self.picker.hidden = false
        
        UIView.animateWithDuration(0.3,
            animations: {
                self.picker.frame = CGRect(x: ((self.view.frame.width / 2) - 143), y: 230, width: 286, height: 291)
                self.picker.alpha = 1
        })
    }
    
    func closePicker()
    {
        UIView.animateWithDuration(0.3,
            animations: {
                self.picker.frame = CGRect(x: ((self.view.frame.width / 2) - 143), y: 200, width: 286, height: 291)
                self.picker.alpha = 0
            },
            completion: { finished in
                self.picker.hidden = true
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        
        let choices = segue.identifier == "Gender" ? ["Male","Female", "Other"] : ["White - NonHispanic", "African American", "Hispanic/Latino", "American Indian", "Other" ]
        
        if let popupView = segue.destinationViewController as? PopupViewController {
            
            popupView.choiceArray = choices
            
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
