import UIKit

protocol WishCalendarRouterProtocol: AnyObject {
    func navigateToEventDetail(with event: WishEvent)
}

class WishCalendarRouter: WishCalendarRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = WishCalendarViewController()
        let presenter = WishCalendarPresenter()
        let interactor = WishCalendarInteractor()
        let router = WishCalendarRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToEventDetail(with event: WishEvent) {
        // Implement navigation to event detail screen
    }
}
