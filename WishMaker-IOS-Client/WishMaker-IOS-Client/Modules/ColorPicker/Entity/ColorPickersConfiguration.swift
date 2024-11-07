enum ColorPickerMenu {
    case sliders
}

struct ColorPickersConfiguration {
    static var sliders: Bool = true
    
    static func toDictionary() -> [ColorPickerMenu: Bool] {
        return [
            ColorPickerMenu.sliders: ColorPickersConfiguration.sliders,
        ]
    }
}
