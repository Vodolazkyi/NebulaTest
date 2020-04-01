//
//  AlbumsListViewController.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit
import UI

final class AlbumsListViewController: NiblessController, AlertPresentable, HasCustomView {
    
    typealias CustomView = AlbumListView
    
    // MARK: - Properties
    
    let alert = ApplicationAlert()
    
    private let model: AlbumsListModel
    
    // MARK: - View lifecycle
    
    init(model: AlbumsListModel) {
        self.model = model
        
        super.init()
    }
        
    override func loadView() {
        let customView = CustomView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Private Methods
    
}
