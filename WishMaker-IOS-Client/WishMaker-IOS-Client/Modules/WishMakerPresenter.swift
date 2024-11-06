import UIKit

protocol WishMakerPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didChangeColor(_ color: UIColor)
    func sliderValueChanged(red: Float, green: Float, blue: Float, alpha: Float)
}

final class WishMakerPresenter: WishMakerPresenterProtocol {
    weak var view: WishMakerViewProtocol?
    var interactor: WishMakerInteractorProtocol?
    var router: WishMakerRouterProtocol?
    
    func viewDidLoad() {
        
    }
    
    func sliderValueChanged(red: Float, green: Float, blue: Float, alpha: Float) {
        interactor?.changeColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func didChangeColor(_ color: UIColor) {
        view?.updateBackgroundColor(with: color)
    }
}

