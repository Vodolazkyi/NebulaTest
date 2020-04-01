//
//  AlbumView.swift
//  UI
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import UIKit

public final class AlbumView: NiblessView {
    
    public lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.registerReusableCell(PhotoCollectionCell.self)
        return collection
    }()
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return layout
    }()

    public init() {
        super.init(frame: .zero)
        
        setupView()
        layout()
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func layout() {
        addSubview(collectionView)
        collectionView.layout {
            $0.top.equal(to: layoutMarginsGuide.topAnchor)
            $0.leading.equal(to: leadingAnchor)
            $0.trailing.equal(to: trailingAnchor)
            $0.bottom.equal(to: layoutMarginsGuide.bottomAnchor)
        }
    }
}
