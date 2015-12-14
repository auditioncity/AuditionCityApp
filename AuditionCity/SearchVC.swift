import UIKit

class SearchVC: UIViewController, UIPopoverPresentationControllerDelegate {
   
    @IBOutlet weak var nameSearchField: UITextField!
    @IBOutlet weak var ageFrom: UILabel!
    @IBOutlet weak var ageTo: UILabel!
    @IBOutlet weak var ageRange: RangeSlider!
    
    @IBOutlet weak var equityCB: CheckBox!
    @IBOutlet weak var sagCB: CheckBox!
    @IBOutlet weak var ssdcCB: CheckBox!
    @IBOutlet weak var agmaCB: CheckBox!
    @IBOutlet weak var eftraCB: CheckBox!
    @IBOutlet weak var iatseCB: CheckBox!
    @IBOutlet weak var dgaCB: CheckBox!
    
    
    @IBAction func ageRangePicked(sender: RangeSlider) {
        
        print(sender)
        
        let lowerValue = Int(sender.lowerValue)
        let upperValue = Int(sender.upperValue) 
        
        ageFrom.text = "\(lowerValue)"
        ageTo.text = "\(upperValue)"
   }
   
    @IBOutlet weak var talentAgencyTF: UITextField!
    @IBOutlet weak var unionTF: UITextField!
    @IBOutlet weak var clearButton: Buttons!
    @IBAction func clearButtonTapped(sender: Buttons) {
    
        nameSearchField.text = ""
        talentAgencyTF.text = ""
        unionTF.text = ""
        
        ageRange.lowerValue = 20
        ageRange.upperValue = 20
        
        equityCB.isChecked = false
        sagCB.isChecked = false
        ssdcCB.isChecked = false
        agmaCB.isChecked = false
        eftraCB.isChecked = false
        iatseCB.isChecked = false
        dgaCB.isChecked = false
        
    }
    @IBOutlet weak var okButton: UIButton!
    @IBAction func okButtonTapped(segue: UIStoryboardSegue) {
    
        self.navigationController?.popViewControllerAnimated(true)
    
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
    

    func runSubmit() {
        
            var unions: [String:AnyObject] = [
                "equity" : equityCB.isChecked,
                "sag" : sagCB.isChecked,
                "ssdc": ssdcCB.isChecked,
                "agma": agmaCB.isChecked,
                "eftra": eftraCB.isChecked,
                "iatse": iatseCB.isChecked,
                "dga": dgaCB.isChecked
        ]
    
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var choices = [String]()
        
        switch segue.identifier! {
            
            case "Gender" : choices = ["Male","Female"]
            
            case "Race" : choices = ["Black or African American", "Hispanic/Latino", "Asian/Pacific Islander", "White or Caucasian", "American Indian/Alaskan Native", "Other"]
            
            case "EyeColor" : choices = ["Blue", "Brown", "Hazel", "Green", "Black", "Grey", "Purple"]
            
            case "HairColor" : choices = ["Blonde", "Brown", "Hazel", "Grey", "Black", "Red", "White", "Other", "None"]
            
        default : choices = []
        
        }
        
        
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
