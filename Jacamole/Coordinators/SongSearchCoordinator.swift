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
		let apiClient = SongsAPIClient()
		let songSearchVC = SongsListViewController(navigationTitle: "Search", iNeedSearchBar: true, iNeedCloseButton: false, songsAPIClient: apiClient)
        navigationController.pushViewController(songSearchVC, animated: false)
    }
}

