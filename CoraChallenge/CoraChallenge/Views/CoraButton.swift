//
//  CoraButton.swift
//  CoraChallenge
//
//  Created by Alysson Moreira on 03/06/24.
//

import UIKit

final class CoraButton: UIButton {
    
    struct Style {
        let font: UIFont?
        let backgroundColor: UIColor
        let tintColor: UIColor
    }
    
    enum Metrics {
        static var cornerRadius: CGFloat = 16
        static var defaultFontSize: CGFloat = 14
        static var largeFontSize: CGFloat = 16
    }

    init(frame: CGRect = .zero, style: Style = .default) {
        super.init(frame: frame)
        setup(with: style)
        additionalSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view is not intended for Interface Builder.")
    }
    
    private func setup(with style: Style) {
        titleLabel?.font = style.font
        setTitleColor(
            style.tintColor,
            for: .normal
        )
        imageView?.tintColor = style.tintColor
        backgroundColor = style.backgroundColor
    }
    
    private func additionalSettings() {
        clipsToBounds = true
        layer.cornerRadius = Metrics.cornerRadius
    }
    
}
