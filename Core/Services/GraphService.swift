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
    
    public init() {}
    
    public func obtainAlbums(completion: @escaping (Result<AlbumData, Error>) -> Void) {
        makeRequest(with: "/me", params: ["fields": "albums.fields(count, name, picture.fields(url))"]) { [weak self] result in
            switch result {
            case .success(let data):
                self?.decode(data: data, path: "albums", completion: completion)

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func obtainPhotoDataForAlbum(with id: String, completion: @escaping (Result<PhotoData, Error>) -> Void) {
        makeRequest(with: id, params: ["fields": "photos.fields(picture.type(large))"]) { [weak self] result in
            
            switch result {
            case .success(let data):
                self?.decode(data: data, path: "photos", completion: completion)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func obtainImagesForPhoto(with id: String, completion: @escaping (Result<[ImageData], Error>) -> Void) {
        makeRequest(with: id, params: ["fields": "images"]) { [weak self] result in
            
            switch result {
            case .success(let data):
                self?.decode(data: data, path: "images", completion: completion)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func makeRequest(with path: String, params: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let graphRequest = GraphRequest(graphPath: path, parameters: params)
        graphRequest.start { _, result, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = result as? [String: Any] {
                completion(.success(data))
            } else {
                completion(.failure(GraphServiceError.cantParse))
            }
        }
    }
    
    private func decode<T: Decodable>(data: [String: Any], path: String, completion: @escaping (Result<T, Error>) -> Void) {
        do {
             let photoData = try self.decoder.decode(
                 T.self,
                 from: JSONSerialization.data(withJSONObject: data[path] as Any, options: [])
             )
             completion(.success(photoData))
         } catch {
             completion(.failure(error))
         }
    }
}
