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
                self?.showPopularSongs(navigationTitle: sectionTitle)
            case 1:
                break
            case 2:
                self?.showFavoriteSongs(navigationTitle: sectionTitle)
            default:
                break
            }
        }
        
        songsMenuVC.didTapOnGenreCell = {
            [weak self] genreTitle in
            self?.showSongsOnGenre(genreTitle: genreTitle)
        }
        
        navigationController.pushViewController(songsMenuVC, animated: false)
    }
    
    func showPopularSongs(navigationTitle: String) {
        let vc = PopularMusicViewController(navigationTitle: navigationTitle)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showSongsOnGenre(genreTitle: String) {
        let vc = SongsByGenresViewController(genre: genreTitle)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showFavoriteSongs(navigationTitle: String) {
        let vc = FavoritesViewController(navigationTitle: navigationTitle, iNeedSearchBar: false, iNeedCloseButton: true)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}

