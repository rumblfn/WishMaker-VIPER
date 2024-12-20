import UIKit

final class CustomSlider: UIView {
    enum Constants {
        static let titleTopMargin: CGFloat = 10
        static let titleLeadingMargin: CGFloat = 20
        static let sliderBottomMargin: CGFloat = 10
        static let sliderLeadingMargin: CGFloat = 20
        static let backgroundColor: UIColor = .white
    }
    
    var valueChanged: (() -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, _ min: Double = 0.0, _ max: Double = 1.0, _ defaultValue: Double = 0) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.value = Float(defaultValue)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleView.pinCenterX(to: centerXAnchor)
        titleView.pinTop(to: topAnchor, Constants.titleTopMargin)
        titleView.pinLeft(to: leadingAnchor, Constants.titleLeadingMargin)
        
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinCenterX(to: centerXAnchor)
        slider.pinBottom(to: bottomAnchor, Constants.sliderBottomMargin)
        slider.pinLeft(to: leadingAnchor, Constants.sliderLeadingMargin)
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?()
    }
}

