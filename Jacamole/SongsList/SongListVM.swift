import Foundation

class SongsListViewModel {
    var viewModelChanged: (() -> Void)?
    
    private(set) var songsVM = [Song]() {
        didSet {
            self.viewModelChanged?()
        }
    }
    
    private let songsAPIClient: SongsAPIClient
    
    init(
        songsAPIClient: SongsAPIClient,
        songsVM: [Song] = [Song]()
    ) {
        self.songsAPIClient = songsAPIClient
        self.songsVM = songsVM
    }
    
    func updateSongs(_ songs: [Song]) {
        self.songsVM = songs
    }
    
    func seachSongs(by query: String) {
        self.songsAPIClient.searchSongs(query: query) {
            [weak self] songs in
            self?.songsVM = songs
        }
    }
    
    var heartHandler: (_ song: Song) -> Void {
        return { [weak self] song in
            //            guard let self = self else { return }
            StorageManager.shared.save(song: song, in: .favourite)
        }
    }
    
}
