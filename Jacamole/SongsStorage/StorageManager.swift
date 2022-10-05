//
//  StorageManager.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 05.10.2022.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SongsCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func getSongGroups() -> [String: [Song]] {
        let request: NSFetchRequest<SongGroupEntity> = SongGroupEntity.fetchRequest()
        var songGroups = [String: [Song]]()
        
        do {
            let songGroupEntities = try context.fetch(request)
            
            songGroupEntities.forEach { songGroupEntity in
                
                guard let title = songGroupEntity.title,
                      let songEntities = songGroupEntity.songs?.allObjects as? [SongEntity] else {
                    print("ERROR converting NSSet TO Array of SongEntities")
                    return
                }
                
                let songs = Song.generateArray(from: songEntities)
                
                songGroups[title] = songs
            }
        } catch {
            print("Error fetching data from context", error.localizedDescription)
            return songGroups
        }
        
        print(songGroups)
        
        return songGroups
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
