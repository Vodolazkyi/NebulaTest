//
//  PhotoPreviewView.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit
import Kingfisher

public final class PhotoPreviewView: NiblessView {
    
    private let photoPreviewView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public init() {
        super.init(frame: .zero)
        
        setupView()
        layout()
    }
    
    public func configure(with url: URL?) {
        photoPreviewView.kf.indicatorType = .activity
        photoPreviewView.kf.setImage(with: url)
    }
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func layout() {
        photoPreviewView.layout(in: self)
    }
}
