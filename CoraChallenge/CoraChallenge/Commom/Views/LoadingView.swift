import UIKit

final class LoadingView: CodedView {

    enum Metrics {
        
        static let dimension: CGFloat = 100
        
        enum WhiteCard {
            static let cornerRadius: CGFloat = 16
        }
        
    }
    
    // MARK: - Subviews
    private let whiteCardView = {
        let view = UIView()
        view.layer.cornerRadius = Metrics.WhiteCard.cornerRadius
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicator = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - CodedView Life Cycle
    override func addSubviews() {
        addSubviews(
            whiteCardView,
            activityIndicator
        )
    }
    
    override func constrainSubviews() {
        constrainWhiteCardView()
        constrainActivityIndicator()
    }
    
    override func configureAdditionalSettings() {
        backgroundColor = .translucentGray
    }
    
    private func constrainWhiteCardView() {
        NSLayoutConstraint.activate(
            whiteCardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            whiteCardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            whiteCardView.widthAnchor.constraint(equalToConstant: Metrics.dimension),
            whiteCardView.heightAnchor.constraint(equalToConstant: Metrics.dimension)
        )
    }
    
    private func constrainActivityIndicator() {
        NSLayoutConstraint.activate(
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        )
    }

}
