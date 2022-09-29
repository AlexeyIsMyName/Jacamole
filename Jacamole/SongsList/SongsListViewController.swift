import UIKit

class SongsListViewController: UIViewController {
    private let navigationTitle: String
    
    private lazy var songsListView = SongsListView(
        viewModel: SongsListViewModel(songsAPIClient: SongsAPIClient())
    )
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    private lazy var closeButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(pointSize: 17.0,
                                                 weight: .light,
                                                 scale: .default)
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left",
                                                    withConfiguration: config),
                                     style: .plain,
                                     target: self,
                                     action: #selector(popViewControler)
        )
        button.tintColor = UIColor(named: "TextColor")
        
        return button
    }()
    
    private let artistAPIClient = ArtistAPIClient()
    private let albomAPIClient = AlbomAPIClient()
    
    init(navigationTitle: String) {
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = songsListView
        view.backgroundColor = UIColor(named: "BackgroungColor")
        makeSearchBar()

//        self.artistAPIClient.loadArtistSongs(artistID: "463402") {
//            [weak self] tracks in
//            print("________________tracks: \(tracks)______________")
//        }
//
//        self.albomAPIClient.loadAlbomSongs(albomID: "144705") {
//            [weak self] alboms in
//            print("_________alboms: \(alboms)______________")
//        }
    }
    
    private func makeSearchBar() {
        navigationItem.title = navigationTitle
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Song"
        searchController.searchBar.tintColor = UIColor(named: "TextColor") ?? .black
        searchController.searchBar.searchTextField.font = UIFont(name: "Abel-Regular", size: 18.0)
    }
    
    @objc func popViewControler(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SongsListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      let searchBar = searchController.searchBar
  }
    
}