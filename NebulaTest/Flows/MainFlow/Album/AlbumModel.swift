//
//  AlbumModel.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import Core

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

    }
}
