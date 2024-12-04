import UIKit

final class WishStoringViewController: UIViewController {
    enum Constants {
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
        
        static let numberOfSections = 2
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    
    private var wishArray: [String] = ["I wish to add cells to the table", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 // Single AddWishCell
        case 1:
            return wishArray.count // Number of WrittenWishCell
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            guard let addWishCell = cell as? AddWishCell else { return cell }
            addWishCell.addWish = { [weak self] wish in
                self?.wishArray.append(wish)
                self?.table.reloadData()
            }
            return addWishCell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.configure(with: wishArray[indexPath.row])
            return wishCell
        default:
            return UITableViewCell()
        }
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pin(to: view, Constants.tableOffset)
        table.isUserInteractionEnabled = true
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
}
