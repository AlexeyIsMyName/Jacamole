import UIKit


class SongsListViewController: UIViewController {
    private let iNeedSearchBar: Bool
    private let iNeedCloseButton: Bool
    private let navigationTitle: String

	private let songsAPIClient: SongsAPIClient
    
    private lazy var songsListView = SongsListView(
        viewModel: SongsListViewModel(
			songsAPIClient: self.songsAPIClient,
            songsVM: self.songsVM
        )
    )
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    
    var songsVM: [Song] {
        didSet {
            self.songsListView.viewModel.updateSongs(self.songsVM)
        }
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
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    init(
        navigationTitle: String,
        iNeedSearchBar: Bool,
        iNeedCloseButton: Bool,
        songsVM: [Song] = [Song](),
		songsAPIClient: SongsAPIClient
    ) {
        self.navigationTitle = navigationTitle
        self.iNeedSearchBar = iNeedSearchBar
        self.iNeedCloseButton = iNeedCloseButton
        self.songsVM = songsVM
		self.songsAPIClient = songsAPIClient
        
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
        
        self.songsListView.songsLoadedAction = {
            [weak self] in
            guard let self = self, self.iNeedSearchBar else { return }
            self.getNeedSomeAttributes()
            self.navigationItem.searchController = self.searchController
            self.searchController.searchBar.becomeFirstResponder()
        }
        
        self.songsListView.showPlayerVC = {
            [weak self] playerVC in
            guard let self = self else { return }
           
            self.present(playerVC, animated: true)
        }
        
        self.getNeedSomeAttributes()
    }
    
    private func makeSearchBar() {
        navigationItem.title = navigationTitle
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Song"
        searchController.searchBar.tintColor = UIColor(named: "TextColor") ?? .black
        searchController.searchBar.searchTextField.font = UIFont(name: "Abel-Regular", size: 18.0)
        
        self.searchController.searchBar.delegate = self
    }
    
    private func getNeedSomeAttributes() {
        navigationItem.searchController = iNeedSearchBar ? searchController : nil
        navigationItem.leftBarButtonItem = iNeedCloseButton ? closeButton : nil
    }
    
    @objc func popViewControler(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SongsListViewController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text, !query.isEmpty else {
           self.songsListView.viewModel.clearSongs()
           return
          }
        // Cancel the currently pending item
        self.pendingRequestWorkItem?.cancel()

        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.songsListView.viewModel.seachSongs(by: query)
        }

        // Save the new work item and execute it after 250 ms
        self.pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
    }

}
