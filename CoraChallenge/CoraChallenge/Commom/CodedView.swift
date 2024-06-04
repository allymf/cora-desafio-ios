//
//  CodedView.swift
//  CoraChallenge
//
//  Created by Alysson Moreira on 03/06/24.
//

import UIKit

protocol CodedViewLifeCycle {
    func addSubviews()
    func constrainSubviews()
    func configureAdditionalSettings()
}

fileprivate extension CodedViewLifeCycle {
    func setupView() {
        addSubviews()
        constrainSubviews()
        configureAdditionalSettings()
    }
}

open class CodedView: UIView, CodedViewLifeCycle {
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("View not intended for Interface Builder.")
    }
    
    func addSubviews() {
        fatalError("You must override addSubviews")
    }
    
    func constrainSubviews() {
        fatalError("You must override constrainSubviews")
    }
    
    func configureAdditionalSettings() {
        fatalError("You must override configureAdditionalSettings")
    }
    
}
