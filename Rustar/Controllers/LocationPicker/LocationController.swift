
import UIKit
import CoreData

class LocationController: UIViewController {
    
    @IBOutlet var mainStackView: UIStackView!
    
    let margin = 15
    
    var brain: LocationPickerBrain!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain = LocationPickerBrain(callBack: createCountryList)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if brain.downloaded {
            return
        }
        
        // Before downloading new data let's show the user previous one that is already saved in our core data In this way user will no longer have to wait for a downloading proccess every time he starts the program.
        brain.fetchData()
        brain.downloadData()
    }
    
    
    
    func createCountryList(_ listOfPlaces: [Location]) {
        
        for i in mainStackView.subviews {
            i.removeFromSuperview()
        }
        
        for place in listOfPlaces {
            
            // creating a stack view to separate all countries by stacks
            let locationViews = UIStackView()
            locationViews.axis = .vertical
            locationViews.spacing = 10
            
            // Country name title
            let countryName = UILabel()
            countryName.text = place.city?.uppercased()
            countryName.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)
            countryName.textColor = UIColor.black
            locationViews.addArrangedSubview(countryName)
            
            // Country Hotel picture
            let image = UIImage(data: place.image! as Data)
            let aspectRatio = image!.size.width / image!.size.height
            let imageView = UIImageView(image: image)
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: aspectRatio).isActive = true
            imageView.contentMode = .scaleAspectFit
            
            // creating horizontal stack view that will keep reviews, old price and current price next to each other
            let info = UIStackView()
            info.axis = .horizontal
            info.spacing = 10
            
            // creating reviews like: "5/5 - exceptional hotel"...
            let reviews = UILabel()
            reviews.text = String(describing: place.rank!)
            reviews.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
            info.addArrangedSubview(reviews)
            
            // adding crossed old price
            let oldPrice = UILabel()
            oldPrice.text = "$\(String(describing: place.oldPrice!))"
            oldPrice.textColor = UIColor.gray
            
            let attributeString =  NSMutableAttributedString(string: oldPrice.text!)
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            oldPrice.attributedText = attributeString
            
            info.addArrangedSubview(oldPrice)
            
            // adding our current price
            let currentPrice = UILabel()
            currentPrice.textColor = Colors.rustarGreen
            currentPrice.text = "$\(String(describing: place.price!))"
            currentPrice.font = UIFont(name: "AvenirNext-Regular", size: 30.0)
            info.addArrangedSubview(currentPrice)
            
            //  adding percentage that shows how much has price dropped from old price to cuurent price by percentage
            let width = (self.view.bounds.width - CGFloat(2 * margin)) / 4
            let height = (self.view.bounds.width - CGFloat(2 * margin)) / aspectRatio / 5
            let x = self.view.bounds.width - CGFloat(2 * margin) - width - CGFloat(margin)
            let y = (self.view.bounds.width - CGFloat(2 * margin)) / aspectRatio - height - CGFloat(margin)
            
            let percentage = RustarButton(frame: CGRect(x: x, y: y, width: width, height: height))
            percentage.roundedCorners = true
            let pricePercentage: Int = (Int(truncating: place.oldPrice!) - Int(truncating: place.price!)) * 100 / Int(truncating: place.oldPrice!)
            percentage.setTitle("-\(pricePercentage)%", for: .normal)
            
            
            imageView.layer.insertSublayer(percentage.layer, above: imageView.layer)
            
            locationViews.addArrangedSubview(imageView)
            locationViews.addArrangedSubview(info)
            mainStackView.addArrangedSubview(locationViews)
        }
    }
    
    @IBAction func touched(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: mainStackView)
        
        for i in mainStackView.subviews {
            if i.frame.minY <= touchPoint.y && touchPoint.y <= i.frame.maxY {
                print((i.subviews[0] as! UILabel).text!)
            }
        }
    }
    
}


















