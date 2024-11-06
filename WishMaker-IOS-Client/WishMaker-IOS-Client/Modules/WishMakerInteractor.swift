import UIKit

protocol WishMakerInteractorProtocol: AnyObject {
    func changeColor(red: Float, green: Float, blue: Float, alpha: Float)
}

final class WishMakerInteractor: WishMakerInteractorProtocol {
    weak var presenter: WishMakerPresenterProtocol?
    
    func changeColor(red: Float, green: Float, blue: Float, alpha: Float) {
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        presenter?.didChangeColor(color)
    }
}
