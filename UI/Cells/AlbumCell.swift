//
//  AlbumCell.swift
//  UI
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import UIKit
import Kingfisher

public final class AlbumCell: NiblessCell {
    
    public struct Config {
        let title: String
        let url: URL?
        
        public init(title: String, url: URL?) {
            self.title = title
            self.url = url
        }
    }
    
    private let albumCoverView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = UILabel()
    
    private var imageTask: DownloadTask?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        imageTask?.cancel()
        albumCoverView.image = nil
    }
    
    public func configure(with config: Config) {
        titleLabel.text = config.title
        albumCoverView.kf.indicatorType = .activity
        imageTask = albumCoverView.kf.setImage(with: config.url)
    }
    
    private func layout() {
        addSubview(albumCoverView)
        albumCoverView.layout {
            $0.leading.equal(to: leadingAnchor, offsetBy: 16)
            $0.top.equal(to: topAnchor, offsetBy: 16)
            $0.bottom.equal(to: bottomAnchor, offsetBy: -16)
            $0.width.equal(to: 80)
            $0.height.equal(to: 80)
        }
        
        addSubview(titleLabel)
        titleLabel.layout {
            $0.leading.equal(to: albumCoverView.trailingAnchor, offsetBy: 16)
            $0.trailing.equal(to: trailingAnchor, offsetBy: -16)
            $0.centerY.equal(to: centerYAnchor)
        }
    }
}
