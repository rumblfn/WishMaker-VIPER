import UIKit

class WishEventCell: UICollectionViewCell {
    struct Constants {
        static let offset: CGFloat = 10
        static let cornerRadius: CGFloat = 8
        static let backgroundColor: UIColor = .white
        
        static let titleTop: CGFloat = 10
        static let titleLeading: CGFloat = 10
        static let titleFont: UIFont = .boldSystemFont(ofSize: 16)
        
        static let descriptionTop: CGFloat = 5
        static let descriptionLeading: CGFloat = 10
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        
        static let startDateTop: CGFloat = 5
        static let startDateLeading: CGFloat = 10
        static let startDateFont: UIFont = .systemFont(ofSize: 12)
        
        static let endDateTop: CGFloat = 5
        static let endDateLeading: CGFloat = 10
        static let endDateBottom: CGFloat = 10
        static let endDateFont: UIFont = .systemFont(ofSize: 12)
    }
    
    // MARK: - Properties
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEvent) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offset),
            wrapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset),
            wrapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset),
            wrapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offset)
        ])
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: Constants.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.titleLeading),
            titleLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.titleLeading)
        ])
        titleLabel.font = Constants.titleFont
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .darkGray
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionTop),
            descriptionLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.descriptionLeading),
            descriptionLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.descriptionLeading)
        ])
        descriptionLabel.font = Constants.descriptionFont
    }
    
    private func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.textColor = .gray
        NSLayoutConstraint.activate([
            startDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.startDateTop),
            startDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.startDateLeading),
            startDateLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.startDateLeading)
        ])
        startDateLabel.font = Constants.startDateFont
    }
    
    private func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.textColor = .gray
        NSLayoutConstraint.activate([
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: Constants.endDateTop),
            endDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.endDateLeading),
            endDateLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.endDateLeading),
            endDateLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -Constants.endDateBottom)
        ])
        endDateLabel.font = Constants.endDateFont
    }
}
