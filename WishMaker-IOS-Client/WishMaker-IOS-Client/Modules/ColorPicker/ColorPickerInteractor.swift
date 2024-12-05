import UIKit

protocol ColorPickerInteractorProtocol: AnyObject {
    func initColor()
    func initButtons()
    func changePickerState(pickerType: ColorPickerMenu)
    func changeColor(red: Float, green: Float, blue: Float, alpha: Float)
}

final class ColorPickerInteractor: ColorPickerInteractorProtocol {
    weak var presenter: ColorPickerPresenterProtocol?
    
    private enum Constants {
        static let appColorKey = "SavedColor"
    }
    
    private let defaults = UserDefaults.standard
    
    private lazy var appColor: ColorPicker = {
        if let savedDataAppColor = defaults.data(forKey: Constants.appColorKey),
           let savedAppColor = try? JSONDecoder().decode(ColorPicker.self, from: savedDataAppColor){
            return savedAppColor
        }
        return ColorPicker()
    }()
    
    func initColor() {
        presenter?.didChangeColor(appColor.toColor())
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
        appColor = ColorPicker(red: red, green: green, blue: blue, alpha: alpha)
        
        // Probably it's not the best way to store color, because it updates on each user slider activation action.
        // Let me know how to do it correctly.
        if let encoded = try? JSONEncoder().encode(appColor) {
            defaults.set(encoded, forKey: Constants.appColorKey)
        }
        
        presenter?.didChangeColor(appColor.toColor())
    }
}
