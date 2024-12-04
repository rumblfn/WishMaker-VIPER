import UIKit

protocol WishStoringRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

final class WishStoringRouter: WishStoringRouterProtocol {
    static func createModule() -> UIViewController {
        let view = WishStoringViewController()
        let interactor = WishStoringInteractor()
        let router = WishStoringRouter()
        let presenter = WishStoringPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}
