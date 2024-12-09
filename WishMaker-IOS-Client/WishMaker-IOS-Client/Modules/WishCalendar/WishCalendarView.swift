import UIKit

protocol WishCalendarViewProtocol: AnyObject {
    func showEvents(_ events: [WishEvent])
}

class WishCalendarViewController: UIViewController {
    enum Constants {
        static let contentInset: UIEdgeInsets = UIEdgeInsets()
        static let collectionTop: CGFloat = 10
        static let cornerRadius: CGFloat = 20
        static let buttonFontSize: CGFloat = 14
        static let creationButtonText: String = "Добавить"
        
    }
    
    var presenter: WishCalendarPresenterProtocol!
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let wishCreationButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollection()
        configureCreationButton()
        presenter.viewDidLoad()
    }
    
    private func configureCreationButton() {
        wishCreationButton.translatesAutoresizingMaskIntoConstraints = false
        wishCreationButton.layer.cornerRadius = Constants.cornerRadius
        wishCreationButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        wishCreationButton.setTitle(Constants.creationButtonText, for: .normal)
        wishCreationButton.addTarget(self, action: #selector(creationButtonPressed), for: .touchUpInside)
        wishCreationButton.backgroundColor = .systemRed
        view.addSubview(wishCreationButton)
        wishCreationButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 16)
        wishCreationButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 16)
        wishCreationButton.setWidth(mode: .equal, 100)
        wishCreationButton.setHeight(mode: .equal, 50)
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
    }
    
    @objc
    private func creationButtonPressed() {
        let wishCreationModule = WishEventCreationRouter.createModule()
        present(wishCreationModule, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        presenter.configure(cell: cell, at: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectEvent(at: indexPath.item)
    }
}

// MARK: - WishCalendarViewProtocol
extension WishCalendarViewController: WishCalendarViewProtocol {
    func showEvents(_ events: [WishEvent]) {
        collectionView.reloadData()
    }
}
