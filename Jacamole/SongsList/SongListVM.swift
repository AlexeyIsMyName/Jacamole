import Foundation

class SongsListViewModel {
    var viewModelChanged: (() -> Void)?
    
    private(set) var songsVM = [SongListItemViewModel]() {
        didSet {
            self.viewModelChanged?()
        }
    }
    
    private var filteredSongs = [SongListItemViewModel]()
    
    private let songsAPIClient: SongsAPIClient
    
    init(songsAPIClient: SongsAPIClient) {
        self.songsAPIClient = songsAPIClient
        self.loadSongs()
    }
    
}

private extension SongsListViewModel {
    
    /*
    func loadSongs() {
        self.songsAPIClient.loadPopularMonthSongs(tag: "") {
            [weak self] songs in
            guard let self = self else { return }
            
            self.songsVM = songs.map { SongListItemViewModel(song: $0) }
        }
    }
     */
    
    func loadSongs() {
        self.songsVM = StorageManager.shared.getFavoriteSongs().map { SongListItemViewModel(song: $0) }
    }
    
//    func filterContentForSearchText(_ searchText: String,
//                                    category: SongListItemViewModel? = nil) {
//      filteredSongs = songsVM.filter { (song: Song) -> Bool in
//        return song.name.lowercased().contains(searchText.lowercased())
//      }
//    }
//    
}
