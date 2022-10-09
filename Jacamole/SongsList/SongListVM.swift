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
    
//    var heartHandler: (_ song: Song) -> Void {
//        return { song in
//            StorageManager.shared.save(song, in: .favourite)
//        }
//    }
    
    func clearSongs() {
      self.songsVM.removeAll()
     }
    
    func loadNextSongs() {
        self.songsAPIClient.loadNextTenSongs() {
            songs in
            self.songsVM += songs
            print("_____________________---songsVM: \(self.songsVM)")
        }
    }
    
}
