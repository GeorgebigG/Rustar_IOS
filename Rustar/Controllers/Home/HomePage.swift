
import UIKit

class HomePage : UIViewController {
    
    @IBOutlet var countryName: UIButton!
    
    @IBOutlet var checkInField: UITextField!
    @IBOutlet var checkOutField: UITextField!
    
    @IBOutlet var whereButton: UIButton!
    @IBOutlet var whenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
//        if let location = LocationController.country {
//            countryName.setTitle(location, for: .normal)
//        } else {
//            countryName.setTitle("Where", for: .normal)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func picksDate(_ sender: UITextField) {
        let datePickerKeyboard = UIDatePicker()
        datePickerKeyboard.datePickerMode = .date
        sender.inputView = datePickerKeyboard
        datePickerKeyboard.addTarget(self, action: #selector(self.datePickerValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        if checkInField.isEditing {
            checkInField.text = dateFormatter.string(from: sender.date)
        } else {
            checkOutField.text = dateFormatter.string(from: sender.date)
        }
    }
}
