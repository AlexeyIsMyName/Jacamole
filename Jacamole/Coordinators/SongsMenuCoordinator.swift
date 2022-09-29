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
}

// MARK: - Flow methods
private extension SongsMenuCoordinator {
    
    func showSongsMenu() {
        let songsMenuVC = SongsCollectionViewController()
        navigationController.pushViewController(songsMenuVC, animated: false)
    }
}

