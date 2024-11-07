import UIKit

struct ColorPicker {
    enum Constants {
        static let lowerBound: Float = 0.0
        static let upperBound: Float = 1.0
        static let floatRange: ClosedRange<Float> = Constants.lowerBound...Constants.upperBound
    }
    
    let red: Float
    let green: Float
    let blue: Float
    let alpha: Float
    
    init() {
        self.red = Float.random(in: Constants.floatRange)
        self.green = Float.random(in: Constants.floatRange)
        self.blue = Float.random(in: Constants.floatRange)
        self.alpha = Constants.upperBound
    }
    
    init(red: Float, green: Float, blue: Float, alpha: Float) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    func toColor() -> UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}
