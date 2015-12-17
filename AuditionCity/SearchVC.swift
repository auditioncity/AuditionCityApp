import UIKit

class SearchVC: UIViewController, UIPopoverPresentationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
   
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
    
    @IBOutlet weak var genderButton: Buttons!
    @IBOutlet weak var eyeColorButton: Buttons!
    @IBOutlet weak var hairColorButton: Buttons!
    @IBOutlet weak var raceButton: Buttons!
    
    
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
        ageRange.upperValue = 80
        ageFrom.text = "20"
        ageTo.text = "80"
        
        
        equityCB.isChecked = false
        sagCB.isChecked = false
        ssdcCB.isChecked = false
        agmaCB.isChecked = false
        eftraCB.isChecked = false
        iatseCB.isChecked = false
        dgaCB.isChecked = false
        
        genderButton.setTitle("Gender", forState: .Normal)
        raceButton.setTitle("Race", forState: .Normal)
        eyeColorButton.setTitle("Eye Color", forState: .Normal)
        hairColorButton.setTitle("Hair Color", forState: .Normal)
        
    }
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBAction func okButtonTapped(segue: UIStoryboardSegue) {
    
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:
            UIKeyboardWillShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    
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
            
            // set the closure code to be called
            
            popupView.madeChoice = { choice in
                
                switch segue.identifier! {
                 
                case "Gender" :
                    
                    self.genderButton.setTitle(choice, forState: .Normal)
                    
                case "Race" :
                    
                    self.raceButton.setTitle(choice, forState: .Normal)
                    
                case "EyeColor" :
                    
                    self.eyeColorButton.setTitle(choice, forState: .Normal)
                    
                case "HairColor" :
                    
                    self.hairColorButton.setTitle(choice, forState: .Normal)
                    
                default : ""
                
                }
                
            }
            
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
 
    func keyboardWillShow(sender: NSNotification) {
        
        if nameSearchField.isFirstResponder()  {
        
        print(nameSearchField.isFirstResponder()) // test for nameSearchField
        
        } else {
            
            self.view.frame.origin.y = -150
        }
    }

    func keyboardWillHide(sender: NSNotification) {
        
        self.view.frame.origin.y = 0
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }

}
