
import UIKit

struct FirstPageJSONData : Decodable {
    
    let city : String
    let price: Decimal
    let old_price: Decimal
    let url : String
    let rank : Double
}

struct FirstPageJSONDataFrame : Decodable {
    let Sheet1 : [FirstPageJSONData]
}
