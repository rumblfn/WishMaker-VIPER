import UIKit

protocol ColorPickerRouterProtocol: AnyObject {
    static func createModule() -> ColorPickerViewController
}

final class ColorPickerRouter: ColorPickerRouterProtocol {
    static func createModule() -> ColorPickerViewController {
        let view = ColorPickerViewController()
        let presenter = ColorPickerPresenter()
        let interactor = ColorPickerInteractor()
        let router = ColorPickerRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
