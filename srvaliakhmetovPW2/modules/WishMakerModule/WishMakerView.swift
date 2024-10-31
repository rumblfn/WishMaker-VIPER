import UIKit

protocol WishMakerViewProtocol: AnyObject {
    func updateBackgroundColor(with color: UIColor)
}

final class WishMakerViewController: UIViewController, WishMakerViewProtocol {
    enum Constants {
        static let backgroundColor: UIColor = .systemPink
        static let titleFontSize: CGFloat = 32
        static let titleTopMargin: CGFloat = 30
        static let titleLeadingMargin: CGFloat = 20
        static let descriptionFontSize: CGFloat = 20
        static let descriptionTopMargin: CGFloat = 20
        static let descriptionTextColor: UIColor = UIColor(red: 0, green: 0.04, blue: 0.34, alpha: 1)
        static let stackBottomMargin: CGFloat = 40
        static let stackLeadingMargin: CGFloat = 20
        static let stackCornerRadius: CGFloat = 20
        
        static let titleText: String = "WishMaker"
        static let descriptionText: String = "Move the sliders and observe the changes."
        
        static let buttonShowText: String = "show sliders"
        static let buttonHideText: String = "hide sliders"
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        static let redSliderText: String = "Red"
        static let greenSliderText: String = "Green"
        static let blueSliderText: String = "Blue"
        static let alphaSliderText: String = "Alpha"
    }
    
    var presenter: WishMakerPresenterProtocol?
    
    private var titleView: UILabel!
    private var descriptionView: UILabel!
    private var buttonView: UIButton!
    private var sliderRed: CustomSlider!
    private var sliderGreen: CustomSlider!
    private var sliderBlue: CustomSlider!
    private var sliderAlpha: CustomSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
        sliderValueChanged()
    }
    
    func updateBackgroundColor(with color: UIColor) {
        view.backgroundColor = color
    }
    
    private func sliderValueChanged() {
        presenter?.sliderValueChanged(
            red: sliderRed.slider.value,
            green: sliderGreen.slider.value,
            blue: sliderBlue.slider.value,
            alpha: sliderAlpha.slider.value
        )
    }
}

extension WishMakerViewController {
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        configureTitle()
        configureDescription()
        configureButton()
        configureSliders()
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
    
    private func configureButton() {
        buttonView = UIButton(type: .system)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.setTitle(Constants.buttonHideText, for: .normal)
        buttonView.setTitleColor(.black, for: .normal)
        buttonView.backgroundColor = .white
        buttonView.layer.cornerRadius = 8
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        buttonView.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        view.addSubview(buttonView)
        
        buttonView.pinCenter(to: view)
    }
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackCornerRadius
        stack.clipsToBounds = true
        
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
            stack.addArrangedSubview(slider)
            slider.valueChanged = sliderValueChanged
        }
        
        stack.pinCenterX(to: view)
        stack.pinLeft(to: view, Constants.stackLeadingMargin)
        stack.pinBottom(to: view, Constants.stackBottomMargin)
    }
}
