import Foundation

class SongsByGenresVM {
    var viewModelChanged: (() -> Void)?
    private(set) var songsVM = [Song]()
    
    private let apiClient = SongsAPIClient()
    private let genre: String
    
    init(genre: String) {
        self.genre = genre
    }

    func viewWillAppear() {
        self.apiClient.loadPopularMonthSongs(tag: self.genre) {
            [weak self] songs in
            guard let self = self else { return }
            
            self.songsVM = songs //.map { SongListItemViewModel(song: $0) }
            self.viewModelChanged?()
        }
    }
    
}
