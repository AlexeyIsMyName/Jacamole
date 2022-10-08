import UIKit

class SongsByGenresViewController: SongsListViewController {
    private let viewModel: SongsByGenresVM
    
    init(genre: String) {
        self.viewModel = SongsByGenresVM(genre: genre)
        super.init(navigationTitle: genre.capitalized, iNeedSearchBar: false, iNeedCloseButton: true)
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
