import UIKit

class FavoriteCoordinator: Coordinator {
    private let navigationController = AppNavigationController()
    
    // MARK: - API
    override var rootViewController: UIViewController? {
        return navigationController
    }
    
    override func start() {
        showFavoriteSongs()
    }
}

// MARK: - Flow methods
private extension FavoriteCoordinator {
    
    func showFavoriteSongs() {
        let favoriteVC = SongsListViewController()
        navigationController.pushViewController(favoriteVC, animated: false)
    }
}

