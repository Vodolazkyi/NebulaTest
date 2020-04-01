//
//  AlbumModel.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import Core

enum AlbumModelEvent: Event {
    case showPhotoPreview(photoId: String)
}

protocol AlbumDelegate: class {
    func dataDidChange()
    func errorDidOccur(_ error: Error)
}

final class AlbumModel: EventNode {
    
    // MARK: - Properties.
    
    var photos: [Photo] { photoData }
    
    weak var delegate: AlbumDelegate?
    
    private let photoService: PhotoService
    private let album: Album
    
    private var photoData = [Photo]() {
        didSet {
            delegate?.dataDidChange()
        }
    }
    
    // MARK: - Init.
    
    init(_ parent: EventNode, photoService: PhotoService, album: Album) {
        self.photoService = photoService
        self.album = album
        super.init(parent: parent)
    }
    
    func screenLoaded() {
        photoService.obtainPhotoDataForAlbum(with: album.id) { [weak self] result in
            switch result {
            case .success(let photoData):
                self?.photoData = photoData.data.sorted(by: { $0.id < $1.id })
                
            case .failure(let error):
                self?.delegate?.errorDidOccur(error)
            }
        }
    }
    
    func showPhotoPreview(with index: Int) {
        let item = photoData[index]
        raise(event: AlbumModelEvent.showPhotoPreview(photoId: item.id))
    }
}
