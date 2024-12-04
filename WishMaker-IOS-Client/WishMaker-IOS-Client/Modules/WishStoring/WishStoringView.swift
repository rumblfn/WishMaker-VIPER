import UIKit

protocol WishStoringViewProtocol: AnyObject {
    func reloadData()
    func showError(_ error: Error)
}

final class WishStoringViewController: UIViewController, WishStoringViewProtocol {

    var presenter: WishStoringPresenterProtocol!

    private let tableView: UITableView = UITableView()
    
    private enum Constants {
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - WishStoringViewProtocol Methods
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.layer.cornerRadius = Constants.tableCornerRadius
        tableView.separatorStyle = .none
        tableView.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.tableOffset),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableOffset),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableOffset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.tableOffset)
        ])
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let reuseIdentifier = presenter.cellIdentifier(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        presenter.configure(cell: cell, at: indexPath)
        return cell
    }
}
