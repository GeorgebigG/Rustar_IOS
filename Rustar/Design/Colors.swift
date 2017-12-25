
import UIKit

class Colors {
    
    public static let rustarGreen = color(0x00, 0x84, 0x4a, 0xff)
    public static let yellowPressed = color(0xe0, 0xb6, 0x46, 0xff)
//    public static let darkBackground = color()
    
    static func color(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: (r) / 255, green: (g) / 255, blue: (b) / 255, alpha: (a) / 255)
    }
    
}
