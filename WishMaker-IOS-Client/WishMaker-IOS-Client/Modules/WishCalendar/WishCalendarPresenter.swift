import UIKit

protocol WishCalendarPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectEvent(at index: Int)
    func numberOfRows(in section: Int) -> Int
    func configure(cell: UICollectionViewCell, at indexPath: IndexPath)
}

class WishCalendarPresenter: WishCalendarPresenterProtocol {
    weak var view: WishCalendarViewProtocol?
    var interactor: WishCalendarInteractorProtocol?
    var router: WishCalendarRouterProtocol?
    
    var events: [WishEvent] = []
    
    func viewDidLoad() {
        interactor?.fetchEvents()
    }
    
    func didSelectEvent(at index: Int) {
        let event = events[index]
        router?.navigateToEventDetail(with: event)
    }
    
    func numberOfRows(in section: Int) -> Int {
        return events.count
    }
    
    func configure(cell: UICollectionViewCell, at indexPath: IndexPath) {
        guard let wishEventCell = cell as? WishEventCell else {
            return
        }
        let event = events[indexPath.item]
        wishEventCell.configure(with: event)
    }
}

// MARK: - WishCalendarInteractorOutputProtocol
extension WishCalendarPresenter: WishCalendarInteractorOutputProtocol {
    func didFetchEvents(_ events: [WishEvent]) {
        self.events = events
        view?.showEvents(events)
    }
}

