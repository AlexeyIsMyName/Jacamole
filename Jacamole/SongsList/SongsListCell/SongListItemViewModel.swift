
class SongListItemViewModel {
    
    var songName: String {
        song.name
    }
    
    var songArtist: String {
        song.artistName
    }
    
    var imageAdress: String {
        song.image
    }
    
    var heartHandler: () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            StorageManager.shared.save(song: self.song, in: .favourite)
        }
    }
    
    private let song: Song
    
    required init(song: Song) {
        self.song = song
    }
    
}
