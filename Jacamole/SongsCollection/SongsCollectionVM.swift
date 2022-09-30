//
//  SongsCollectionVM.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 30.09.2022.
//

import Foundation


class SongsCollectionViewModel {
    var viewModelChanged: (() -> Void)?
    
    private(set) var songsVM = [SongListItemViewModel]() {
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
            
            print("______________songs: \(songs)")
            self.songsVM = songs.map { SongListItemViewModel(song: $0) }
        }
    }
    
}
