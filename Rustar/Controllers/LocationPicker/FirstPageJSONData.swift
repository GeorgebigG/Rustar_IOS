
import UIKit

struct FirstPageJSONData : Decodable {
    
    let city : String
    let price: Decimal
    let old_price: Decimal
    let url : String
    let rank : Decimal
}

struct FirstPageJSONDataFrame : Decodable {
    let Sheet1 : [FirstPageJSONData]
}
