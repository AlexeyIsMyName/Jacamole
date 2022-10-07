
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
    
    var songID: String {
        song.id
    }
    
    var heartHandler: () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            if StorageManager.shared.isFavourite(songID: self.song.id) {
                StorageManager.shared.delete(self.song, from: .favourite)
            } else {
                StorageManager.shared.save(self.song, in: .favourite)
            }
        }
    }
    
    private let song: Song
    
    required init(song: Song) {
        self.song = song
    }
    
}
