
import UIKit

struct FirstPageJSONData : Decodable {
    
    let city : String
    let price: Int
    let old_price: Int
    let url : String
    let rank : Double
}

struct FirstPageJSONDataFrame : Decodable {
    let Sheet1 : [FirstPageJSONData]
}
