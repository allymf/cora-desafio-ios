import UIKit

extension UICollectionView {
    func register(_ cellType: UICollectionViewCell.Type) {
        register(
            cellType,
            forCellWithReuseIdentifier: cellType.identifier
        )
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellType.identifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Unable to find cell registered with the following reuseIdentifier: \(cellType.identifier)")
        }
        
        return cell
    }
    
}
