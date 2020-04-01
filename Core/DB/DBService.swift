//
//  DBService.swift
//  Core
//
//  Created by Vodolazkyi Anton on 4/1/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import UIKit
import CoreData

public enum DBClientError: Error {
    case noEntity
}

public final class DBClient {

    // MARK: - Properties
    
    private let modelName: String

    // MARK: - Initialization
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    func saveAlbums(_ albums: [Album]) -> Result<Void, Error> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        let objects = (try? mainObjectContext.fetch(fetchRequest) as? [NSManagedObject]) ?? []
        
        for object in objects {
            mainObjectContext.delete(object)
        }
        
        guard let albumEntity = NSEntityDescription.entity(forEntityName: "Album", in: mainObjectContext) else {
            return .failure(DBClientError.noEntity)
        }
        
        for album in albums {
            let managedObject = NSManagedObject(entity: albumEntity, insertInto: mainObjectContext)
            managedObject.setValue(album.id, forKey: "id")
            managedObject.setValue(album.name, forKey: "name")
            managedObject.setValue(album.count, forKey: "count")
            managedObject.setValue(album.picture.data.url, forKey: "url")
        }
        
        do {
            try mainObjectContext.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func getAlbums() -> Result<[Album], Error> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        
        // swiftlint:disable force_cast
        do {
            let objects = try mainObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            var albums = [Album]()
            
            for object in objects {
                let album = Album(
                    id: object.value(forKey: "id") as! String,
                    count: object.value(forKey: "count") as! Int,
                    name: object.value(forKey: "name") as! String,
                    picture: .init(data: .init(url: object.value(forKey: "url") as! String))
                )
                albums.append(album)
            }
            
            return .success(albums)
        } catch {
            return .failure(error)
        }
        // swiftlint:enable force_cast
    }

    // MARK: - Core Data Stack
    
    private(set) lazy var mainObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
}
