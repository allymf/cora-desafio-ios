import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type) {
        register(
            cellType,
            forCellReuseIdentifier: cellType.identifier
        )
    }
    
    func dequeueResuableCell<Cell: UITableViewCell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellType.identifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Unable to find cell registered with the following reuseIdentifier: \(cellType.identifier)")
        }
        
        return cell
    }
}
