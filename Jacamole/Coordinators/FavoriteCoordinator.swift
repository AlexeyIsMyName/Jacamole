import UIKit

class FavoriteCoordinator: Coordinator {
    private let navigationController = AppNavigationController()
    
    // MARK: - API
    override var rootViewController: UIViewController? {
        navigationController.tabBarItem.image = UIImage(systemName: "heart")
        return navigationController
    }
    
    override func start() {
        showFavoriteSongs()
    }
}

// MARK: - Flow methods
private extension FavoriteCoordinator {
    
    func showFavoriteSongs() {
        let favoriteVC = FavoritesViewController(navigationTitle: "Favorite Title", iNeedSearchBar: true, iNeedCloseButton: false)
        navigationController.pushViewController(favoriteVC, animated: false)
    }
    
}

