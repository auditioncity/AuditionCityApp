import UIKit



class PopupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    var choiceArray: [String] = []
    
    @IBOutlet weak var picker: UIPickerView!
    
  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: 300, height: 275)
    }
    set {
      super.preferredContentSize = newValue
    }
  }
//    @IBAction func okButtonTapped(segue: UIStoryboardSegue) {
//    
//        
//    }
    
    @IBAction func okButtonTapped(sender: Buttons) {
    
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        picker.dataSource = self
        picker.delegate = self
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return choiceArray.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return choiceArray[row]
        
    }
    
}