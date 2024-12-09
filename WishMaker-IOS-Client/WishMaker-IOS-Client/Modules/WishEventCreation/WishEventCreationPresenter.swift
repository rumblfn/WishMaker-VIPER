import UIKit

protocol WishEventCreationPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class WishEventCreationPresenter: WishEventCreationPresenterProtocol {
    weak var view: WishEventCreationViewProtocol?
    var interactor: WishCalendarInteractorProtocol?
    var router: WishEventCreationRouterProtocol?
    
    func viewDidLoad() {
        
    }
}


