//
//  PhotosService.swift
//  Core
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import Foundation

public class PhotoService {
    
    private let graphService: GraphService
    private let dbClient: DBClient
    
    public init(graphService: GraphService, dbClient: DBClient) {
        self.graphService = graphService
        self.dbClient = dbClient
    }
    
    public func obtainAllAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        completion(dbClient.getAlbums())
        
        graphService.obtainAlbums { [weak self] result in
            switch result {
            case .success(let item):
                _ = self?.dbClient.saveAlbums(item.data)
                completion(.success(item.data))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func obtainPhotoDataForAlbum(with id: String, completion: @escaping (Result<PhotoData, Error>) -> Void) {
        
        graphService.obtainPhotoDataForAlbum(with: id) { [weak self] result in
            switch result {
            case .success(let item):
//                _ = self?.dbClient.saveAlbums(item.data)
                completion(.success(item))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
