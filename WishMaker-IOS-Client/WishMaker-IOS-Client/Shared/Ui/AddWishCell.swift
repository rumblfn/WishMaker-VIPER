import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    var addWish: ((String) -> ())?
    
    private enum Constants {
        static let wrapColor: UIColor = .lightGray
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let textViewOffset: CGFloat = 8
        static let buttonOffset: CGFloat = 8
        static let buttonTitle: String = "Add Wish"
    }
    
    private let wishTextView: UITextView = UITextView()
    private let addButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        configureUI()
    }
    
    @available(
        *,
         unavailable
    )
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    private func configureUI() {
        self.isUserInteractionEnabled = true
        
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        
        contentView.addSubview(wrap)
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrap.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.wrapOffsetV),
            wrap.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.wrapOffsetV),
            wrap.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.wrapOffsetH),
            wrap.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.wrapOffsetH)
        ])
        
        wrap.addSubview(wishTextView)
        wishTextView.translatesAutoresizingMaskIntoConstraints = false
        wishTextView.layer.cornerRadius = 8
        wishTextView.layer.borderWidth = 1
        wishTextView.layer.borderColor = UIColor.gray.cgColor
        wishTextView.isEditable = true
        wishTextView.isUserInteractionEnabled = true
        wishTextView.font = UIFont.systemFont(ofSize: 16)
        
        NSLayoutConstraint.activate([
            wishTextView.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.textViewOffset),
            wishTextView.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.textViewOffset),
            wishTextView.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.textViewOffset),
            wishTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        wrap.addSubview(addButton)
        addButton.setTitle(Constants.buttonTitle, for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: wishTextView.bottomAnchor, constant: Constants.buttonOffset),
            addButton.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.buttonOffset),
            addButton.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.buttonOffset),
            addButton.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -Constants.buttonOffset)
        ])
        
        addButton.isUserInteractionEnabled = true
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        guard let text = wishTextView.text, !text.isEmpty else { return }
        addWish?(text)
        wishTextView.text = ""
    }
}
