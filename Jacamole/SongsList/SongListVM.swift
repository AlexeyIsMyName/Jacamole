import Foundation

class SongsListViewModel {
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

private extension SongsListViewModel {
    
    func loadSongs() {
        self.songsAPIClient.loadPopularMonthSongs(tag: "") {
            [weak self] songs in
            guard let self = self else { return }
            
            print("______________songs: \(songs)")
            self.songsVM = songs.map { SongListItemViewModel(song: $0) }
        }
    }
    
}
