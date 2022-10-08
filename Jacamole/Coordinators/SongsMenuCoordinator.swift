import UIKit

class SongsMenuCoordinator: Coordinator {
    private let navigationController = AppNavigationController()
    
    // MARK: - API
    override var rootViewController: UIViewController? {
        navigationController.tabBarItem.image = UIImage(named: "Music")
        return navigationController
    }
    
    override func start() {
        showSongsMenu()
    }
    
    deinit {
        print("SongsMenuCoordinator deinit")
    }
}

// MARK: - Flow methods
private extension SongsMenuCoordinator {
    
    func showSongsMenu() {
        let songsMenuVC = SongsMainViewController()
        
        songsMenuVC.didTapOnCollectionViewSection = {
            [weak self] section, sectionTitle, songs in
            
            switch section {
            case 0:
                self?.showPopularSongs(navigationTitle: sectionTitle, songsVM: songs)
            case 1:
                break
            case 2:
                break
            default:
                break
            }
//            self?.showSongsList(section: section, sectionTitle: sectionTitle, songsVM: songs)
        }
        
        songsMenuVC.didTapOnGenreCell = {
            [weak self] genreTitle in
            self?.showSongsOnGenre(genreTitle: genreTitle)
        }
        
        navigationController.pushViewController(songsMenuVC, animated: false)
    }
    
    func showPopularSongs(navigationTitle: String, songsVM: [Song]) {
        let vc = PopularMusicViewController(navigationTitle: navigationTitle, songsVM: songsVM)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
//    func showSongsList(section: Int, sectionTitle: String, songsVM: [Song]) {
//        let listItemsVMs = songsVM.map { SongListItemViewModel(song: $0) }
//        let vc = SongsListViewController(navigationTitle: sectionTitle, iNeedSearchBar: false, iNeedCloseButton: true, songsVM: listItemsVMs)
//        self.navigationController.pushViewController(vc, animated: true)
//    }
    
    func showSongsOnGenre(genreTitle: String) {
        let vc = SongsByGenresViewController(genre: genreTitle)
        self.navigationController.pushViewController(vc, animated: true)
//        let apiClient = SongsAPIClient()
//        let listItemsVMs = songsVM.map { SongListItemViewModel(song: $0) }
//        let vc = SongsListViewController(navigationTitle: genreTitle, iNeedSearchBar: true, iNeedCloseButton: true, songsVM: listItemsVMs)
//        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showFavoriteSongs(navigationTitle: String, songsVM: [Song]) {
        let vc = FavoritesViewController(navigationTitle: navigationTitle, iNeedSearchBar: false, iNeedCloseButton: true, songsVM: songsVM)
//        let vc = PopularMusicViewController(songsVM: listItemsVMs)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}

