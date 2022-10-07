//
//  PlayerViewModel.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 07.10.2022.
//


// MARK: - Properties
class PlayerViewModel {
    private var audioManager: AudioManager!
    private var songs: [Song]!
    private var songIndex: Int!
    
    var isPlaying: Bool {
        audioManager.isPlaying
    }
    
    var songModelChanged: ((PlayerViewSongModel) -> Void)! {
        didSet {
            setupAudioManager(with: songs, and: songIndex)
        }
    }
    
    private var songModel: PlayerViewSongModel! {
        didSet {
            songModelChanged(songModel)
        }
    }
    
    var timePointChanged: ((Float) -> Void)!
    private var timePoint: Float! {
        didSet {
            timePointChanged(timePoint)
        }
    }
    
    var volume: Float! {
        didSet {
            audioManager.volume = volume
        }
    }
    
    var isTimeSeeking = false
    private var isFavourite: Bool!
    
    init() {
        self.audioManager = AudioManager.shared
        self.volume = audioManager.volume
    }
}

// MARK: - Public func
extension PlayerViewModel {
    func setSongs(_ songs: [Song], startIndex: Int) {
        self.songs = songs
        self.songIndex = startIndex
    }
    
    func backward() {
        audioManager.backward()
    }
    
    func forward() {
        audioManager.forward()
    }
    
    func playOrPause() {
        audioManager.playOrPause()
    }
    
    func seek(to time: Float) {
        audioManager.seek(to: time)
    }
    
    func heartButtonPressed() -> Bool {
        let song = songs[songIndex]
        if StorageManager.shared.isFavourite(songID: song.id) {
            StorageManager.shared.delete(song, from: .favourite)
            return false
        } else {
            StorageManager.shared.save(song, in: .favourite)
            return true
        }
    }
}

// MARK: - Private func
private extension PlayerViewModel {
    private func setupAudioManager(with songs: [Song], and startIndex: Int) {
        audioManager.setupPlayer(with: songs, startFrom: startIndex)

        audioManager.durationHandler = { [weak self] time in
            guard let self = self else { return }
            if !self.isTimeSeeking {
                self.timePoint = Float(time.seconds)
            }
        }

        audioManager.newSongHandler = { [weak self] stringDuration, duration, songIndex in
            guard let self = self else { return }
            
            self.songIndex = songIndex
            
            self.songModel = PlayerViewSongModel(
                stringDuration: stringDuration,
                floatDuration: duration,
                posterImageURL: self.songs[songIndex].image,
                title: self.songs[songIndex].name,
                artist: self.songs[songIndex].artistName,
                isFavourite: self.isFavorite(self.songs[songIndex].id))
        }
    }
    
    private func isFavorite(_ songID: String) -> Bool {
        return StorageManager.shared.isFavourite(songID: songID)
    }
}
