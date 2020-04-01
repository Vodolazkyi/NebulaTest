//
//  PhotoPreviewViewController.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit
import UI

final class PhotoPreviewViewController: NiblessController, HasCustomView, AlertPresentable {
    
    typealias CustomView = PhotoPreviewView
    
    // MARK: - Properties
    
    let alert = ApplicationAlert()
    
    private let model: PhotoPreviewModel
    
    // MARK: - View lifecycle
    
    init(model: PhotoPreviewModel) {
        self.model = model
        super.init()
        
        self.model.delegate = self
    }
    
    override func loadView() {
        let customView = CustomView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.screenLoaded()
    }
}

extension PhotoPreviewViewController: PhotoPreviewModelDelegate {
    
    func imageUrlDidLoaded(url: URL?) {
        customView.configure(with: url)
    }
    
    func errorDidOccur(_ error: Error) {
        showAlert(with: nil, message: error.localizedDescription, style: .alert, actions: [])
    }
}
