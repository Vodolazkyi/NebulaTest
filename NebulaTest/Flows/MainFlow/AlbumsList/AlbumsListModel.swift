//
//  AlbumsListModel.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import Core

enum AlbumsListModelEvent: Event {
    case showAlbum(Album)
}

protocol AlbumsListModelDelegate: class {
    func dataDidChange()
    func errorDidOccur(_ error: Error)
}

final class AlbumsListModel: EventNode {
    
    // MARK: - Properties.
    
    var albums: [Album] { albumsData }
    
    weak var delegate: AlbumsListModelDelegate?
    
    private let photoService: PhotoService
    private var albumsData = [Album]() {
        didSet {
            delegate?.dataDidChange()
        }
    }
    
    // MARK: - Init.
    
    init(_ parent: EventNode, photoService: PhotoService) {
        self.photoService = photoService
        super.init(parent: parent)
    }
    
    func screenLoaded() {
        photoService.obtainAllAlbums { [weak self] result in
            switch result {
            case .success(let albums):
                self?.albumsData = albums.sorted(by: { $0.name < $1.name })
                
            case .failure(let error):
                self?.delegate?.errorDidOccur(error)
            }
        }
    }
    
    func showAlbumDetails(at index: Int) {
        let album = albumsData[index]
        raise(event: AlbumsListModelEvent.showAlbum(album))
    }
}
