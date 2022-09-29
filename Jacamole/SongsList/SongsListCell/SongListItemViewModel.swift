
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
    
    private let song: Song
    
    required init(song: Song) {
        self.song = song
    }
    
}
