//
//  Song+Extension.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 05.10.2022.
//

import Foundation

extension Song {
    
    static func generateSongs(from songEntities: [SongEntity]) -> [Song] {
        
        var songs = [Song]()
        
        songEntities.forEach { songEntity in
            
            guard let genresEntities = songEntity.musicinfo?.tags?.genres?.allObjects as? [GenreEntity] else {
                print("ERROR getting genres entities")
                return
            }
            
            let genres = genresEntities.compactMap() { $0.genre }
            
            let song = Song(
                id: songEntity.id!,
                name: songEntity.name!,
                duration: Int(songEntity.duration),
                artistId: songEntity.artistId!,
                artistName: songEntity.artistName!,
                albumName: songEntity.albumName!,
                albumId: songEntity.albumId!,
                position: Int(songEntity.position),
                audio: songEntity.audio!,
                audiodownload: songEntity.audiodownload!,
                image: songEntity.image!,
                musicinfo: Musicinfo(tags: Tags(genres: genres))
            )
            songs.append(song)
        }
        return songs
    }
}
