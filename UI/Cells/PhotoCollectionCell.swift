//
//  PhotoCollectionCell.swift
//  UI
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import UIKit
import Kingfisher

public final class PhotoCollectionCell: UICollectionViewCell, Reusable {
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var imageTask: DownloadTask?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        imageTask?.cancel()
        photoImage.image = nil
    }
    
    public func configure(with url: URL?) {
        imageTask = photoImage.kf.setImage(with: url)
    }
    
    private func layout() {
        photoImage.layout(in: self)
    }
}
