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
        
        self.model.delegate = self
    }
        
    override func loadView() {
        let customView = CustomView()
        view = customView
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.screenLoaded()
    }
}

extension AlbumsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath, cellType: AlbumCell.self)
        let album = model.albums[indexPath.row]
        cell.configure(with: .init(title: album.name, url: URL(string: album.picture.data.url)))
        
        return cell
    }
}

extension AlbumsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.showAlbumDetails(at: indexPath.row)
    }
}

extension AlbumsListViewController: AlbumsListModelDelegate {
    
    func dataDidChange() {
        customView.tableView.reloadData()
    }
    
    func errorDidOccur(_ error: Error) {
        showAlert(with: nil, message: error.localizedDescription, style: .alert, actions: [])
    }
}
