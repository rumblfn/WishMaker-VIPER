import UIKit

protocol ColorPickerViewProtocol: AnyObject {
    func updateBackgroundColor(with color: UIColor)
    func updateColorPickers(_ value: [ColorPickerMenu: Bool])
}

final class ColorPickerViewController: UIViewController, ColorPickerViewProtocol {
    enum Constants {
        static let titleFontSize: CGFloat = 32
        static let titleTopMargin: CGFloat = 30
        static let titleLeadingMargin: CGFloat = 20
        static let descriptionFontSize: CGFloat = 20
        static let descriptionTopMargin: CGFloat = 20
        static let descriptionTextColor: UIColor = UIColor(red: 0, green: 0.04, blue: 0.34, alpha: 1)
        static let stackBottomMargin: CGFloat = 20
        static let stackLeadingMargin: CGFloat = 20
        static let stackCornerRadius: CGFloat = 20
        
        static let titleText: String = "ColorPicker"
        static let descriptionText: String = "Move the sliders and observe the changes."
        
        static let buttonShowText: String = "show sliders"
        static let buttonHideText: String = "hide sliders"
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        static let redSliderText: String = "Red"
        static let greenSliderText: String = "Green"
        static let blueSliderText: String = "Blue"
        static let alphaSliderText: String = "Alpha"
        
        static let buttonHeight: CGFloat = 60
        static let buttonBottom: CGFloat = 40
        static let buttonSide: CGFloat = 20
        static let buttonText: String = "Add wish"
        static let buttonRadius: CGFloat = 20
    }
    
    var presenter: ColorPickerPresenterProtocol?
    
    private var titleView: UILabel!
    private var descriptionView: UILabel!
    private var togglePickerButtons: [ToggleButton<ColorPickerMenu>: UIView]!
    
    private var slidersStack: UIStackView!
    private var sliderRed: CustomSlider!
    private var sliderGreen: CustomSlider!
    private var sliderBlue: CustomSlider!
    private var sliderAlpha: CustomSlider!
    
    private let addWishButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
    }
    
    func updateBackgroundColor(with color: UIColor) {
        view.backgroundColor = color
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        sliderRed.slider.value = Float(red)
        sliderGreen.slider.value = Float(green)
        sliderBlue.slider.value = Float(blue)
        sliderAlpha.slider.value = Float(alpha)
    }
    
    func updateColorPickers(_ state: [ColorPickerMenu: Bool]) {
        for (button, linkedView) in togglePickerButtons {
            let newValue = state[button.valueFor] ?? false
            button.clicked = newValue
            linkedView.isHidden = !newValue
        }
    }
    
    private func sliderValueChanged() {
        presenter?.sliderValueChanged(
            red: sliderRed.slider.value,
            green: sliderGreen.slider.value,
            blue: sliderBlue.slider.value,
            alpha: sliderAlpha.slider.value
        )
    }
    
    private func pickerButtonClicked(_ value: ColorPickerMenu) {
        presenter?.pickerButtonClicked(pickerType: value)
    }
    
    @objc
    private func addWishButtonPressed() {
        // TODO: write some logic here
    }
}

extension ColorPickerViewController {
    private func configureUI() {
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureSliders()
        configureButtons()
    }
    
    private func configureTitle() {
        titleView = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.titleText
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        
        view.addSubview(titleView)
        
        titleView.pinCenterX(to: view.centerXAnchor)
        titleView.pinLeft(to: view, Constants.titleLeadingMargin)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleLeadingMargin)
    }
    
    private func configureDescription() {
        descriptionView = UILabel()
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.descriptionText
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionView.numberOfLines = 0
        descriptionView.textColor = Constants.descriptionTextColor
        
        view.addSubview(descriptionView)
        
        descriptionView.pinCenterX(to: view)
        descriptionView.pinLeft(to: view, Constants.titleLeadingMargin)
        descriptionView.pinTop(to: titleView.bottomAnchor, Constants.descriptionTopMargin)
    }
    
    private func configureButtons() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let buttonsStack = UIStackView()
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fillProportionally
        buttonsStack.spacing = 10
        scrollView.addSubview(buttonsStack)
        
        scrollView.contentSize = CGSize(width: buttonsStack.frame.size.width, height: buttonsStack.frame.size.height)
        
        togglePickerButtons = [
            ToggleButton(name: "Sliders", valueFor: ColorPickerMenu.sliders): slidersStack
        ]
        
        for (button, _) in togglePickerButtons {
            buttonsStack.addArrangedSubview(button)
            button.onClick = pickerButtonClicked
        }
        
        view.addSubview(buttonsStack)
        
        scrollView.pinLeft(to: view, Constants.titleLeadingMargin)
        scrollView.pinTop(to: descriptionView.bottomAnchor, Constants.descriptionTopMargin)
        
        buttonsStack.pin(to: scrollView)
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)

        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureSliders() {
        slidersStack = UIStackView()
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.axis = .vertical
        view.addSubview(slidersStack)
        
        slidersStack.layer.cornerRadius = Constants.stackCornerRadius
        slidersStack.clipsToBounds = true
        
        let sliders = [
            CustomSlider(title: Constants.redSliderText, Constants.sliderMin, Constants.sliderMax),
            CustomSlider(title: Constants.greenSliderText, Constants.sliderMin, Constants.sliderMax),
            CustomSlider(title: Constants.blueSliderText, Constants.sliderMin, Constants.sliderMax),
            CustomSlider(title: Constants.alphaSliderText, Constants.sliderMin, Constants.sliderMax, Constants.sliderMax)
        ]
        
        sliderRed = sliders[0]
        sliderGreen = sliders[1]
        sliderBlue = sliders[2]
        sliderAlpha = sliders[3]
        
        for slider in sliders {
            slidersStack.addArrangedSubview(slider)
            slider.valueChanged = sliderValueChanged
        }
        
        slidersStack.pinCenterX(to: view)
        slidersStack.pinLeft(to: view, Constants.stackLeadingMargin)
        slidersStack.pinBottom(to: addWishButton.topAnchor, Constants.stackBottomMargin)
    }
}

