//
//  PlayerViewModel.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 07.10.2022.
//

import Foundation

class PlayerViewModel {
    var audioManager: AudioManager!
    var songs: [Song]!
    var songIndex: Int!
    
    var songModelChanged: ((PlayerViewSongModel) -> Void)!
    var songModel: PlayerViewSongModel! {
        didSet {
            songModelChanged(songModel)
        }
    }
    
    var songDurationTimePointInSeconds: Float!
    
    var volume: Float! = 0.5
    
    func setSongs(_ songs: [Song], startIndex: Int) {
        self.songs = songs
        setupAudioManager(with: songs, and: startIndex)
    }
    
    private func setupAudioManager(with songs: [Song], and startIndex: Int) {
        audioManager.setupPlayer(with: songs, startFrom: startIndex)

        audioManager.durationHandler = { [weak self] time in
            guard let self = self else { return }
            self.songDurationTimePointInSeconds = Float(time.seconds)
        }

        audioManager.newSongHandler = { [weak self] stringDuration, duration, songIndex in
            guard let self = self else { return }
            
            self.songModel = PlayerViewSongModel(
                stringDuration: stringDuration,
                floatDuration: duration,
                posterImageURL: self.songs[songIndex].image,
                title: self.songs[songIndex].name,
                artist: self.songs[songIndex].artistName)
        }
    }
}
