import UIKit

protocol WishMakerRouterProtocol: AnyObject {
    static func createModule() -> WishMakerViewController
}

final class WishMakerRouter: WishMakerRouterProtocol {
    static func createModule() -> WishMakerViewController {
        let view = WishMakerViewController()
        let presenter = WishMakerPresenter()
        let interactor = WishMakerInteractor()
        let router = WishMakerRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
