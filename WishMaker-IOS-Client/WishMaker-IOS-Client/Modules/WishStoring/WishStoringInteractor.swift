protocol WishStoringInteractorInputProtocol: AnyObject {
    func fetchWishes()
    func saveWish(_ wish: String)
}

protocol WishStoringInteractorOutputProtocol: AnyObject {
    func didFetchWishes(_ wishes: [String])
    func didFailToFetchWishes(with error: Error)
}

final class WishStoringInteractor: WishStoringInteractorInputProtocol {

    weak var presenter: WishStoringInteractorOutputProtocol?
    
    private var wishes: [String] = []
    
    func fetchWishes() {
        wishes = ["Health and Happiness", "Success and Fulfillment", "Wisdom and Clarity", "Peace and Harmony"]
        presenter?.didFetchWishes(wishes)
    }
    
    func saveWish(_ wish: String) {
        wishes.append(wish)
        presenter?.didFetchWishes(wishes)
    }
}
