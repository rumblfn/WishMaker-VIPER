import UIKit

protocol WishEventCreationRouterProtocol: AnyObject {
    
}

class WishEventCreationRouter: WishEventCreationRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = WishEventCreationView()
        let presenter = WishEventCreationPresenter()
        let router = WishEventCreationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
