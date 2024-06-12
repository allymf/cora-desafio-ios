//
//  StatementAttributeView.swift
//  CoraChallenge
//
//  Created by Alysson Moreira on 11/06/24.
//

import UIKit

final class StatementAttributeView: CodedView {
    
    enum Metrics {
        static let bigFontSize: CGFloat = 16
        static let smallFontSize: CGFloat = 14
        
        static let bigLabelHeight: CGFloat = 24
        static let smallLabelHeight: CGFloat = 20
        
        static let interLabelSpacing: CGFloat = 4
    }
    
    // MARK: - Subviews
    private let titleLabel = {
        let label = UILabel()
        label.text = "Valor"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let valueLabel = {
        let label = UILabel()
        label.text = "R$ 154,00"
        
        label.font = .avenirBold(size: Metrics.bigFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    // MARK: CodedView life cycle
    override func addSubviews() {
        addSubviews(
            titleLabel,
            valueLabel
        )
    }
    
    override func constrainSubviews() {
        constrainTitleLabel()
        constrainValueLabel()
    }

    override func configureAdditionalSettings() {}
    
}

private extension StatementAttributeView {
    
    func constrainTitleLabel() {
        NSLayoutConstraint.activate(
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Metrics.smallLabelHeight)
        )
    }
    
    func constrainValueLabel() {
        NSLayoutConstraint.activate(
            valueLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Metrics.interLabelSpacing
            ),
            valueLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: Metrics.bigLabelHeight)
        )
    }
    
}
