import UIKit

class FavoritesVM {
    
    var viewModelChanged: (() -> Void)?
    var songsVM = StorageManager.shared.getFavoriteSongs()
    
    private(set) var filteredSongs = [Song]()
    
    func filterContentForSearchText(_ searchText: String) {
        self.filteredSongs = songsVM.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        self.viewModelChanged?()
    }
    
    func refresh() {
        filteredSongs = StorageManager.shared.getFavoriteSongs()
        viewModelChanged?()
    }
}

class FavoritesViewController: SongsListViewController {
    private let viewModel = FavoritesVM()
    
	init(navigationTitle: String, iNeedSearchBar: Bool, iNeedCloseButton: Bool) {
		super.init(navigationTitle: navigationTitle, iNeedSearchBar: iNeedSearchBar, iNeedCloseButton: iNeedCloseButton, songsVM: [], songsAPIClient: SongsAPIClient())
        self.songsVM = self.viewModel.songsVM
        
        self.viewModel.viewModelChanged = {
            [weak self] in
            guard let self = self else { return }
            
            self.songsVM = self.viewModel.filteredSongs
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refresh()
    }
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text, !query.isEmpty else {
            self.songsVM = self.viewModel.songsVM
            return
        }
       
        self.viewModel.filterContentForSearchText(query)
    }
}
