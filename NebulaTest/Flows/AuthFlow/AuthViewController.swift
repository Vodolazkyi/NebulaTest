//
//  AuthViewController.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit
import UI
import FBSDKCoreKit
import FBSDKLoginKit

fileprivate let fbPermissions = ["user_photos"]

final class AuthViewController: NiblessController, HasCustomView, AlertPresentable {
    
    typealias CustomView = AuthView
    
    let alert = ApplicationAlert()
    
    private let loginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = fbPermissions
        return button
    }()
    
    // MARK: - Properties
    
    private let model: AuthModel
    
    init(model: AuthModel) {
        self.model = model
        
        super.init()
    }
    
    // MARK: - View lifecycle
    
    override func loadView() {
        let customView = CustomView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLoginButton()
    }
    
    // MARK: - Private Methods
    
    private func addLoginButton() {
        customView.addLoginButton(loginButton)
        loginButton.delegate = self
    }
}

extension AuthViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            showAlert(with: nil, message: error.localizedDescription, style: .alert, actions: [])
        } else if let result = result {
            if result.isCancelled {
                return
            }
            
            if let token = result.token {
                model.login(with: token.tokenString, userId: token.userID)
            } else {
                showAlert(with: nil, message: "Can't obtain token. Try again.", style: .alert, actions: [])
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) { }
}
