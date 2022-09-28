import UIKit

class SongsMenuCoordinator: Coordinator {
    private let navigationController = AppNavigationController()
    
    // MARK: - API
    override var rootViewController: UIViewController? {
        return navigationController
    }
    
    override func start() {
        showSongsMenu()
    }
}

// MARK: - Flow methods
private extension SongsMenuCoordinator {
    
    func showSongsMenu() {
        let songsMenuVC = ViewController()
        navigationController.pushViewController(songsMenuVC, animated: false)
    }
}

