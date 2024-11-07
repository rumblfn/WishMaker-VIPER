import UIKit

protocol ColorPickerInteractorProtocol: AnyObject {
    func initColor()
    func initButtons()
    func changePickerState(pickerType: ColorPickerMenu)
    func changeColor(red: Float, green: Float, blue: Float, alpha: Float)
}

final class ColorPickerInteractor: ColorPickerInteractorProtocol {
    weak var presenter: ColorPickerPresenterProtocol?
    
    func initColor() {
        let color = ColorPicker()
        presenter?.didChangeColor(color.toColor())
    }
    
    func initButtons() {
        let object = ColorPickersConfiguration.toDictionary()
        presenter?.didChangeButtons(object)
    }
    
    func changePickerState(pickerType: ColorPickerMenu) {
        switch pickerType {
        case ColorPickerMenu.sliders:
            ColorPickersConfiguration.sliders = !ColorPickersConfiguration.sliders
        }
        initButtons()
    }
    
    func changeColor(red: Float, green: Float, blue: Float, alpha: Float) {
        let color = ColorPicker(red: red, green: green, blue: blue, alpha: alpha)
        presenter?.didChangeColor(color.toColor())
    }
}
