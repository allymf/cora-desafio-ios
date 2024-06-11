import UIKit

open class GenericTableViewCell<View: UIView>: UITableViewCell {

    let customView = {
        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        contentView.addSubview(customView)
        constrainCustomView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("View not intended for Interface Builder.")
    }
    
    func constrainCustomView() {
        NSLayoutConstraint.activate(
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        )
    }

}
