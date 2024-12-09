import UIKit

protocol WishEventCreationViewProtocol: AnyObject {
    
}

class WishEventCreationView: UIViewController {
    enum Constants {
        
    }
    
    var presenter: WishEventCreationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
    }
}

extension WishEventCreationView: WishEventCreationViewProtocol {
    
}
