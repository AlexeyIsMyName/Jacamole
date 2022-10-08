import UIKit

class SongsByPopularMusic {
    
    var viewModelChanged: (() -> Void)?
    private(set) var songsVM = [Song]()
    
    private let apiClient = SongsAPIClient()

    func viewWillAppear() {
        self.apiClient.loadPopularMonthSongs(tag: "") {
            [weak self] songs in
            guard let self = self else { return }
            
            self.songsVM = songs //.map { SongListItemViewModel(song: $0) }
            self.viewModelChanged?()
        }
    }
    
}


class PopularMusicViewController: SongsListViewController {
    private let viewModel: SongsByPopularMusic
    
    init(navigationTitle: String) {
        self.viewModel = SongsByPopularMusic()
        super.init(navigationTitle: navigationTitle, iNeedSearchBar: false, iNeedCloseButton: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.viewModelChanged = {
            [weak self] in
            guard let self = self else { return }
            
            self.songsVM = self.viewModel.songsVM
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.viewWillAppear()
    }

}
