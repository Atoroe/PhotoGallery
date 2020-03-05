import Foundation
import UIKit

extension UIView {
    func roundCorners(radius: CGFloat? = 10) {
        guard let radius = radius else {
            return
        }
        self.layer.cornerRadius = radius
    }
    
    func dropShadow(shadowColor: UIColor?) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor?.cgColor ?? UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func addGradient(startPointColor: UIColor, endPointColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [startPointColor.cgColor, endPointColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
    
}
