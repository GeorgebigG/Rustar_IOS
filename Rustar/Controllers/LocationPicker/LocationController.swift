
import UIKit
import CoreData

class LocationController: UIViewController {
    
    var countryList : [FirstPageJSONData]!
    @IBOutlet var mainStackView: UIStackView!
    
    let margin = 15
    
    var jsonIsDone = false, viewDidLayoutSubviewsAlready = false
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let fetchFromData: NSFetchRequest<Location> = Location.fetchRequest()
            locations = try AppDelegate.persistentContainer.viewContext.fetch(fetchFromData)
            
            if locations.count > 0 {
                for i in locations {
                    print("\(i.hotelName!), \(i.price!), \(i.oldPrice!), \(i.rank!)")
                }
            } else {
                print("Empty")
            }
            
            
        } catch let error {
            print(error)
        }
        
        
//        let jsonUrlLink = "https://script.googleusercontent.com/macros/echo?user_content_key=wM3n5XpINfTWF0qjQLN__bPTANVymebQ6Wphc36h-67bTlzht7qkbcSQqr1nRTnZEssvlsOk8KXmrlxd760YStC--FPCY_M9OJmA1Yb3SEsKFZqtv3DaNYcMrmhZHmUMWojr9NvTBuBLhyHCd5hHa1ZsYSbt7G4nMhEEDL32U4DxjO7V7yvmJPXJTBuCiTGh3rUPjpYM_V0PJJG7TIaKpyr_lAc9V4NXdV3kMcIDX22Jnodg7Qef_ld4DFc4yMLCJlAEelXzvDauUxDB_P7jPMKiW3k6MDkf31SIMZH6H4k&lib=MbpKbbfePtAVndrs259dhPT7ROjQYJ8yx"
//
//        guard let url = URL(string: jsonUrlLink) else { return }
//
//        URLSession.shared.dataTask(with: url) {
//            (data, response, err) in
//
//            guard let data = data else { return }
//
//            do {
//                let json = try JSONDecoder().decode(FirstPageJSONDataFrame.self, from: data)
//                self.countryList = json.Sheet1
//
//                self.jsonIsDone = true
//                if self.viewDidLayoutSubviewsAlready {
//                    DispatchQueue.main.async {
//                        self.createCountryList()
//                    }
//                }
//
//            } catch let jsonErr {
//                print("json error:", jsonErr)
//            }
//         }.resume()
    }
    
    func createCountryList() {
        
        for view in mainStackView.subviews {
            view.removeFromSuperview()
        }
        
        for i in countryList {
            do {
                // creating a stack view to separate all countries by stacks
                let locationViews = UIStackView()
                locationViews.axis = .vertical
                locationViews.spacing = 10
                
                // Country name title
                let countryName = UILabel()
                countryName.text = i.city.uppercased()
                countryName.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)
                countryName.textColor = UIColor.black
                locationViews.addArrangedSubview(countryName)
                
                // Country Hotel picture
                let image = try UIImage(data: NSData(contentsOf: NSURL(string: i.url)! as URL) as Data)!
                let aspectRatio = image.size.width / image.size.height
                let imageView = UIImageView(image: image)
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: aspectRatio).isActive = true
                imageView.contentMode = .scaleAspectFit
                
                // creating horizontal stack view that will keep reviews, old price and current price next to each other
                let info = UIStackView()
                info.axis = .horizontal
                info.spacing = 10
                
                // creating reviews like: "5/5 - exceptional hotel"...
                let reviews = UILabel()
                reviews.text = String(i.rank)
                reviews.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
                info.addArrangedSubview(reviews)
                
                // adding crossed old price
                let oldPrice = UILabel()
                oldPrice.text = "$\(i.old_price)"
                oldPrice.textColor = UIColor.gray
                
                let attributeString =  NSMutableAttributedString(string: oldPrice.text!)
                attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                oldPrice.attributedText = attributeString
                
                info.addArrangedSubview(oldPrice)
                
                // adding our current price
                let currentPrice = UILabel()
                currentPrice.textColor = Colors.rustarGreen
                currentPrice.text = "$\(i.price)"
                currentPrice.font = UIFont(name: "AvenirNext-Regular", size: 30.0)
                info.addArrangedSubview(currentPrice)
                
                //  adding percentage that shows how much has price dropped from old price to cuurent price by percentage
                let width = (self.view.bounds.width - CGFloat(2 * margin)) / 4
                let height = (self.view.bounds.width - CGFloat(2 * margin)) / aspectRatio / 5
                let x = self.view.bounds.width - CGFloat(2 * margin) - width - CGFloat(margin)
                let y = (self.view.bounds.width - CGFloat(2 * margin)) / aspectRatio - height - CGFloat(margin)
                
                let percentage = RustarButton(frame: CGRect(x: x, y: y, width: width, height: height))
                percentage.roundedCorners = true
                // i.old_price - i.price / i.old_price * 100
                let pricePercentage = NSDecimalNumber(decimal: i.old_price - i.price / i.old_price * 100)
                if pricePercentage as Decimal >= Decimal(0){
                    percentage.setTitle("-\(Int(pricePercentage))%", for: .normal)
                } else {
                    percentage.setTitle("\(Int(pricePercentage))%", for: .normal)
                }
                
                
                imageView.layer.insertSublayer(percentage.layer, above: imageView.layer)
                
                locationViews.addArrangedSubview(imageView)
                locationViews.addArrangedSubview(info)
                mainStackView.addArrangedSubview(locationViews)
                
                // Save data
                let location = Location(context: AppDelegate.persistentContainer.viewContext)
                location.hotelName = i.city.uppercased()
                let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
                location.image = imageData
                location.price = NSDecimalNumber(decimal: i.price)
                location.oldPrice = NSDecimalNumber(decimal: i.old_price)
                location.rank = NSDecimalNumber(value: i.rank)
                AppDelegate.saveContext()
                
            } catch let jsonErr {
                print(jsonErr)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        viewDidLayoutSubviewsAlready = true
    }
    
    @IBAction func countryIsPicked(_ sender: UITapGestureRecognizer) {
        print("geire")
    }
}


















