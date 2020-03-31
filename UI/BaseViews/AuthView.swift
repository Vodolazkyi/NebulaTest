//
//  AuthView.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit

public final class AuthView: NiblessView {
    
    public let loginButtonContainer = UIView()
    
    public init() {
        super.init(frame: .zero)
        
        setupView()
        layout()
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    public func addLoginButton(_ button: UIButton) {
        addSubview(button)
        button.layout {
            $0.centerX.equal(to: centerXAnchor)
            $0.centerY.equal(to: centerYAnchor)
        }
    }
    
    private func layout() {
        addSubview(loginButtonContainer)
        loginButtonContainer.layout {
            $0.centerX.equal(to: centerXAnchor)
            $0.centerY.equal(to: centerYAnchor)
            $0.height.equal(to: 50)
            $0.leading.equal(to: leadingAnchor, offsetBy: 20)
            $0.trailing.equal(to: trailingAnchor, offsetBy: -20)
        }
    }
}
