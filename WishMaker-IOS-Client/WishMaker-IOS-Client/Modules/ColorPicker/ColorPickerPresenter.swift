import UIKit

protocol ColorPickerPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didChangeButtons(_ buttonsForValues: [ColorPickerMenu])
    func didChangeColor(_ color: UIColor)
    func sliderValueChanged(red: Float, green: Float, blue: Float, alpha: Float)
}

final class ColorPickerPresenter: ColorPickerPresenterProtocol {
    weak var view: ColorPickerViewProtocol?
    var interactor: ColorPickerInteractorProtocol?
    var router: ColorPickerRouterProtocol?
    
    func viewDidLoad() {
        interactor?.initColor()
        interactor?.initButtons()
    }
    
    func didChangeButtons(_ buttonsForValues: [ColorPickerMenu]) {
        
    }
    
    func sliderValueChanged(red: Float, green: Float, blue: Float, alpha: Float) {
        interactor?.changeColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func didChangeColor(_ color: UIColor) {
        view?.updateBackgroundColor(with: color)
    }
}

