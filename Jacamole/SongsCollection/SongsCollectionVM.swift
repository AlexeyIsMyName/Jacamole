//
//  SongsCollectionVM.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 30.09.2022.
//

class SongsCollectionViewModel {
    var viewModelChanged: (() -> Void)?
    
    private(set) var songsVM = [[String: [Any]]]() {
        didSet {
            self.viewModelChanged?()
        }
    }
    
    private let songsAPIClient: SongsAPIClient
    
    init(songsAPIClient: SongsAPIClient) {
        self.songsAPIClient = songsAPIClient
        self.loadSongs()
    }
}

private extension SongsCollectionViewModel {
    
    func loadSongs() {
        self.songsAPIClient.loadPopularMonthSongs(tag: "") {
            [weak self] songs in
            guard let self = self else { return }
            
//            print("______________songs: \(songs)")
            self.songsVM.append(
                ["Popular Music": songs]
            )
            self.appendGenres()
        }
    }
    
    func appendGenres() {
        let songGenres = SongsCollectionGenres.allCases
        
        self.songsVM.append(
            ["Genres" : songGenres]
        )
        getSongsFromSongCoreData()
    }
    
    func getSongsFromSongCoreData() {
        let songGroups = StorageManager.shared.getAllSongGroups()
        
        songGroups.forEach { title, songs in
            if title != StorageManager.Groups.searchedSongs.rawValue {
                self.songsVM.append(
                    [title: songs]
                )
            }
        }
    }
}
