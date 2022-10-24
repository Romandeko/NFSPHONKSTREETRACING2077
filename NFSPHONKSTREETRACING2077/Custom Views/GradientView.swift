/// Долго не мог найти, как сделать закгругленные углы, используя градиент, который ты показывал, поэтому сделал по-другому
import UIKit

class GradienButton : UIButton {

func applyGradient(colours: [UIColor], cornerRadius: CGFloat?, startPoint: CGPoint, endPoint: CGPoint)  {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.frame = self.bounds
    if let cornerRadius = cornerRadius {
        gradient.cornerRadius = cornerRadius
    }
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    gradient.colors = colours.map { $0.cgColor }
    self.layer.insertSublayer(gradient, at: 0)
  }
}

