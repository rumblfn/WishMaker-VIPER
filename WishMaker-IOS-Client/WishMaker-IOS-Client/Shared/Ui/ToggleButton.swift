import UIKit

final class ToggleButton<T>: UIView {
    var onTitle: String = "Off: "
    var offTitle: String = "On: "
    
    var onClick: ((T) -> Void)?
    let valueFor: T
    
    var button = UIButton(type: .system)
    
    init(name: String, valueFor: T) {
        self.onTitle += name
        self.offTitle += name
        self.valueFor = valueFor
        
        super.init(frame: .zero)
        button.addTarget(self, action: #selector(triggerEvent), for: .touchUpInside)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        
        button.setTitle(offTitle, for: .normal)
        
        button.pin(to: self)
    }
    
    @objc
    private func triggerEvent() {
        onClick?(self.valueFor)
    }
}

