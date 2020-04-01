//
//  PhotoPreviewModel.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import Core

protocol PhotoPreviewModelDelegate: class {
    func imageUrlDidLoaded(url: URL?)
    func errorDidOccur(_ error: Error)
}

final class PhotoPreviewModel: EventNode {
    
    // MARK: - Properties.
    
    weak var delegate: PhotoPreviewModelDelegate?
    
    private let photoId: String
    private let photoService: PhotoService
        
    // MARK: - Init.
    
    init(_ parent: EventNode, photoId: String, photoService: PhotoService) {
        self.photoId = photoId
        self.photoService = photoService
        
        super.init(parent: parent)
    }
    
    func screenLoaded() {
        photoService.obtainImagesForPhoto(with: photoId) { [weak self] result in
            switch result {
            case .success(let images):
                let source = images.sorted(by: { $0.width > $1.width }).first?.source
                self?.delegate?.imageUrlDidLoaded(url: URL(string: source ?? ""))
                
            case .failure(let error):
                self?.delegate?.errorDidOccur(error)
            }
        }
    }
}
