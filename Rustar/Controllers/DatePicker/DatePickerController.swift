
import UIKit

class DatePickerController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    static var checkInDate: String?
    
    @IBOutlet var checkInField: UITextField!
    @IBOutlet var checkOutField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goBackToHomePage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateIsEditting(_ sender: UITextField) {
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
