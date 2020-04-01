//
//  GraphService.swift
//  Core
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

public enum GraphServiceError: Error {
    case cantParse
}

public final class GraphService {
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public init() {

    }
    
    public func obtainAlbums(completion: @escaping (Result<AlbumData, Error>) -> Void) {
        let graphRequest = GraphRequest(graphPath: "/me", parameters: ["fields": "albums.fields(count, name, picture.fields(url))"])
        graphRequest.start { [weak self] _, result, error in
            guard let `self` = self else { return }
            
            if let error = error {
                completion(.failure(error))
            } else if let data = result as? [String: Any] {
                do {
                    let albums = try self.decoder.decode(
                        AlbumData.self,
                        from: JSONSerialization.data(withJSONObject: data["albums"] as Any, options: [])
                    )
                    completion(.success(albums))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(GraphServiceError.cantParse))
            }
        }
    }
}
