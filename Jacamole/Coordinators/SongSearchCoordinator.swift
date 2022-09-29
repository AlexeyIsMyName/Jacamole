import UIKit

class SongSearchCoordinator: Coordinator {
    private let navigationController = AppNavigationController()
    
    // MARK: - API
    override var rootViewController: UIViewController? {
        navigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        return navigationController
    }
    
    override func start() {
        showSongSearch()
    }
}

// MARK: - Flow methods
private extension SongSearchCoordinator {
    
    func showSongSearch() {
        let songSearchVC = SongsListViewController(navigationTitle: "Search")
        navigationController.pushViewController(songSearchVC, animated: false)
    }
}

