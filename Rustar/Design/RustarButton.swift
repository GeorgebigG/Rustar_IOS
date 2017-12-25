
import UIKit

@IBDesignable
class RustarButton: UIButton {
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        changeStyle()
    }
    
    func changeStyle() {
        self.backgroundColor = Colors.rustarGreen
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitle("\(self.titleLabel!.text!)", for: .normal) 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = Colors.yellowPressed
        self.sendActions(for: .touchDown)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = Colors.rustarGreen
        self.sendActions(for: .touchUpInside)
    }
}
