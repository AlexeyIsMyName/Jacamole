//
//  StorageManager.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 05.10.2022.
//

import Foundation
import CoreData

class StorageManager {
    
    enum Groups: String {
        case favourite = "Favourite Songs"
        case previouslyPlayed = "Previously Played Songs"
        case searchedSongs = "Searched Songs"
    }
    
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
    
    private func loadSongEntities() throws -> [SongGroupEntity] {
        let request: NSFetchRequest<SongGroupEntity> = SongGroupEntity.fetchRequest()
        
        do {
            let songGroupEntities = try context.fetch(request)
            return songGroupEntities
        } catch {
            throw error
        }
    }
    
    private func deleteIfEmpty(_ group: Groups) {
        do {
            let songGroupEntities = try loadSongEntities()
            
            guard let songGroupEntity = songGroupEntities.first(where: { $0.title == group.rawValue }) else {
                return
            }
            
            if songGroupEntity.songs?.count == 0 {
                context.delete(songGroupEntity)
            }
            
            saveContext()
        } catch {
            print("Error fetching data from context", error.localizedDescription)
        }
    }
    
    func getFavoriteSongs() -> [Song] {
        return getAllSongGroups()[Groups.favourite.rawValue] ?? []
    }
    
    func getSearchedSongs() -> [Song] {
        return getAllSongGroups()[Groups.searchedSongs.rawValue] ?? []
    }
    
    func getAllSongGroups() -> [String: [Song]] {
        var songGroups = [String: [Song]]()
        
        do {
            let songGroupEntities = try loadSongEntities()
            
            songGroupEntities.forEach { songGroupEntity in
                
                guard let title = songGroupEntity.title,
                      let songEntities = songGroupEntity.songs?.allObjects as? [SongEntity] else {
                    print("ERROR converting NSSet TO Array of SongEntities")
                    return
                }
                
                let songs = Song.generateSongs(from: songEntities)
                
                songGroups[title] = songs
            }
        } catch {
            print("Error fetching data from context", error.localizedDescription)
            return songGroups
        }
        
        return songGroups
    }
    
    func isFavourite(songID: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<SongGroupEntity> = SongGroupEntity.fetchRequest()
        
        let groupPredicate = NSPredicate(
            format: "title = %@", StorageManager.Groups.favourite.rawValue
        )

        let songIDPredicate = NSPredicate(
            format: "SUBQUERY(" +
                "songs, " +
                "$song, " +
                "$song.id ==[cd] \"\(songID)\"" +
                ").@count > 0"
        )
        
        fetchRequest.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                groupPredicate,
                songIDPredicate
            ]
        )
        
        do {
            let songGroupEntities = try context.fetch(fetchRequest)
            
            if !songGroupEntities.isEmpty {
                return true
            }
        } catch {
            print("ERROR with the fetching of Request", error.localizedDescription)
        }
        
        return false
    }
    
    func save(_ song: Song, in group: StorageManager.Groups) {
        
        var songGroupEntities = [SongGroupEntity]()
        
        do {
            songGroupEntities = try loadSongEntities()
        } catch {
            print("Error fetching data from context", error.localizedDescription)
        }
        
        let songGroupEntity = songGroupEntities.first { $0.title == group.rawValue } ?? SongGroupEntity(context: context)
        
        songGroupEntity.title = group.rawValue
    
        let songEntity = SongEntity(context: context)
        songEntity.parentSongGroup = songGroupEntity
        
        songEntity.id = song.id
        songEntity.name = song.name
        songEntity.duration = Int64(song.duration)
        songEntity.artistId = song.artistId
        songEntity.artistName = song.artistName
        songEntity.albumName = song.albumName
        songEntity.albumId = song.albumId
        songEntity.position = Int64(song.position)
        songEntity.audio = song.audio
        songEntity.audiodownload = song.audiodownload
        songEntity.image = song.image
        
        let musicInfoEntity = MusicinfoEntity(context: context)
        musicInfoEntity.parentSong = songEntity
        
        let tagsEntity = TagsEntity(context: context)
        tagsEntity.parentMusicInfo = musicInfoEntity
        
        song.musicinfo.tags.genres.forEach { genre in
            let genreEntity = GenreEntity(context: context)
            genreEntity.genre = genre
            genreEntity.parentTag = tagsEntity
        }
        
        saveContext()
    }
    
    func delete(_ song: Song, from group: StorageManager.Groups) {
        
        do {
            let songGroupEntities = try loadSongEntities()
            
            guard let songGroupEntity = songGroupEntities.first(where: { $0.title == group.rawValue }) else {
                return
            }
                
            guard let songEntities = songGroupEntity.songs?.allObjects as? [SongEntity] else {
                print("ERROR converting NSSet TO Array of SongEntities")
                return
            }
            
            if let songEntity = songEntities.first(where: { $0.id == song.id }) {
                context.delete(songEntity)
            }
            
            saveContext()
            deleteIfEmpty(group)
        } catch {
            print("Error fetching data from context", error.localizedDescription)
            return
        }
        return
    }
    
    func removeAll() {
        
        var songGroupEntities = [SongGroupEntity]()
        
        do {
            songGroupEntities = try loadSongEntities()
        } catch {
            print("Error fetching data from context", error.localizedDescription)
        }
        
        songGroupEntities.forEach { songGroupEntity in
            context.delete(songGroupEntity)
        }
        saveContext()
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
