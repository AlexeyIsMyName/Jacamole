import UIKit

class AppCoordinator: Coordinator {

    private let tabBarController = AppTabBarController()
    
    // MARK: - API
    
    override var rootViewController: UIViewController? {
        tabBarController
    }
    
    override func start() {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.start()
        }
        tabBarController.selectedIndex = 1
    }
    
    // MARK: - Init
    override init() {
        super.init()
        
        setupTabBar()
    }
}

// MARK: - Config
private extension AppCoordinator {
    
    func setupTabBar() {
        
        let tabs = [
            FavoriteCoordinator(),
            SongsMenuCoordinator(),
            SongSearchCoordinator(),
        ]
        
        tabBarController.viewControllers = tabs.map({ $0.rootViewController! })
        childCoordinators.append(contentsOf: tabs)
    }
}
