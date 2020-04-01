//
//  AlbumViewController.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit
import UI

final class AlbumViewController: NiblessController, AlertPresentable, HasCustomView {
    
    typealias CustomView = AlbumView

    // MARK: - Properties
    
    let alert = ApplicationAlert()

    private let model: AlbumModel

    // MARK: - View lifecycle
    
    init(model: AlbumModel) {
        self.model = model
        super.init()
        
        self.model.delegate = self
    }
    
    override func loadView() {
        let customView = CustomView()
        view = customView
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.screenLoaded()
    }
}

extension AlbumViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: PhotoCollectionCell.self)
        let item = model.photos[indexPath.row]
        cell.configure(with: URL(string: item.picture))
        return cell
    }
}

extension AlbumViewController: UICollectionViewDelegate {
    
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width / 3)
    }
}

extension AlbumViewController: AlbumDelegate {
    
    func dataDidChange() {
        customView.collectionView.reloadData()
    }
    
    func errorDidOccur(_ error: Error) {
        showAlert(with: nil, message: error.localizedDescription, style: .alert, actions: [])
    }
}
