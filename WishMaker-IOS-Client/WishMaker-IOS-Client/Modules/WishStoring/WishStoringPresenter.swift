import UIKit

protocol WishStoringPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellIdentifier(for indexPath: IndexPath) -> String
    func configure(cell: UITableViewCell, at indexPath: IndexPath)
    func didAddWish(_ wish: String)
}

final class WishStoringPresenter: WishStoringPresenterProtocol {

    weak var view: WishStoringViewProtocol?
    var interactor: WishStoringInteractorInputProtocol
    var router: WishStoringRouterProtocol?
    
    private var wishes: [String] = []
    
    init(view: WishStoringViewProtocol,
         interactor: WishStoringInteractorInputProtocol,
         router: WishStoringRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.fetchWishes()
    }
    
    func numberOfSections() -> Int {
        return 2 // Section 0: AddWishCell, Section 1: Wishes
    }
    
    func numberOfRows(in section: Int) -> Int {
        return section == 0 ? 1 : wishes.count
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        return indexPath.section == 0 ? AddWishCell.reuseId : WrittenWishCell.reuseId
    }
    
    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let addWishCell = cell as? AddWishCell else { return }
            addWishCell.addWish = { [weak self] wishText in
                self?.didAddWish(wishText)
            }
        } else {
            guard let wishCell = cell as? WrittenWishCell else { return }
            let wish = wishes[indexPath.row]
            wishCell.configure(with: wish)
        }
    }
    
    func didAddWish(_ wish: String) {
        interactor.saveWish(wish)
    }
}

// MARK: - Interactor Output Protocol
extension WishStoringPresenter: WishStoringInteractorOutputProtocol {
    func didFetchWishes(_ wishes: [String]) {
        self.wishes = wishes
        view?.reloadData()
    }
    
    func didFailToFetchWishes(with error: Error) {
        view?.showError(error)
    }
}
