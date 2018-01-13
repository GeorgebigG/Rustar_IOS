
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var others: UIBarButtonItem!
    
    var homeButtonCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImageView(image: UIImage(named: "Logo"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        homeButtonCenter = homeButton.center
//        homeButton.center.y = homeButton.center.y - homeButton.frame.height
//        homeButton.alpha = 0
    }
    
    @IBAction func logIn(_ sender: RustarButton) {
//        if homeButtonCenter == homeButton.center {
//            etc(self.navigationItem.leftBarButtonItem!)
//        }
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if homeButtonCenter == homeButton.center {
//            etc(self.navigationItem.leftBarButtonItem!)
//        }
        self.view.endEditing(true)
    }
    
    @IBAction func etc(_ sender: UIBarButtonItem) {
        if homeButtonCenter == homeButton.center {
            UIView.animate(withDuration: 0.3, animations: {
                self.homeButton.center.y = self.homeButton.center.y - self.homeButton.frame.height
                self.homeButton.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.homeButton.center = self.homeButtonCenter
                self.homeButton.alpha = 1
            })
        }
    }
    
    @IBAction func backToHomePage(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

