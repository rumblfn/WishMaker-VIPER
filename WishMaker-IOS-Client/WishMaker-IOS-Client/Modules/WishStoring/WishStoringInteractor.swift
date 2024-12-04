import Foundation

protocol WishStoringInteractorInputProtocol: AnyObject {
    func fetchWishes()
    func saveWish(_ wish: String)
}

protocol WishStoringInteractorOutputProtocol: AnyObject {
    func didFetchWishes(_ wishes: [String])
    func didFailToFetchWishes(with error: Error)
}

final class WishStoringInteractor: WishStoringInteractorInputProtocol {
    private enum Constants {
        static let wishesKey = "SavedWishes"
    }
    
    weak var presenter: WishStoringInteractorOutputProtocol?
    
    private var wishes: [String] = []
    private let defaults = UserDefaults.standard
    
    func fetchWishes() {
        if let savedWishes = defaults.array(forKey: Constants.wishesKey) as? [String] {
            wishes = savedWishes
        } else {
            wishes = []
        }
        // wishes = ["Health and Happiness", "Success and Fulfillment", "Wisdom and Clarity", "Peace and Harmony"]
        presenter?.didFetchWishes(wishes)
    }
    
    func saveWish(_ wish: String) {
        wishes.append(wish)
        defaults.set(wishes, forKey: Constants.wishesKey)
        presenter?.didFetchWishes(wishes)
    }
}
