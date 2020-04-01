//
//  Album.swift
//  Core
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import Foundation

public struct Album: Codable {
    
    public let count: Int
    public let name: String
    public let picture: UrlData
}
