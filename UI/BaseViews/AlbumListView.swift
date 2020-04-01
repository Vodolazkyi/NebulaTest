//
//  AlbumListView.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit

public final class AlbumListView: NiblessView {
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.registerReusableCell(AlbumCell.self)
        tableView.backgroundColor = .clear
        return tableView
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
        addSubview(tableView)
        tableView.layout {
            $0.top.equal(to: layoutMarginsGuide.topAnchor)
            $0.leading.equal(to: leadingAnchor)
            $0.trailing.equal(to: trailingAnchor)
            $0.bottom.equal(to: layoutMarginsGuide.bottomAnchor)
        }
    }
}
