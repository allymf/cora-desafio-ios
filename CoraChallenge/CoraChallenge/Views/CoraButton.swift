//
//  CoraButton.swift
//  CoraChallenge
//
//  Created by Alysson Moreira on 03/06/24.
//

import UIKit

final class CoraButton: UIButton {
    
    enum FontName{}
    
    enum Metrics {
        static var cornerRadius: CGFloat = 16
        static var defaultFontSize: CGFloat = 14
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = Metrics.cornerRadius
        titleLabel?.font = UIFont(
            name: "Avenir",
            size: Metrics.defaultFontSize
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setFontSize(_ size: CGFloat) {
        titleLabel?.font = UIFont(
            name: "Avenir",
            size: size
        )
    }
    
}
