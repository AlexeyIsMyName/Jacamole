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
    
    func setupLKTab() {
        guard var tabViewControllers = tabBarController.viewControllers else { return }

        let songsMenuCoordinator = SongsMenuCoordinator()
        songsMenuCoordinator.start()

        tabViewControllers[1] = songsMenuCoordinator.rootViewController!

        childCoordinators.append(songsMenuCoordinator)

//        // Remove unnecessary coordinator
//        if lkCoordinator is LKCoordinator {
//            if let indx = childCoordinators.firstIndex(where: { $0 is LKAuthIntroCoordinator }) { popCoordinator(childCoordinators[indx]) }
//        } else {
//            if let indx = childCoordinators.firstIndex(where: { $0 is LKCoordinator }) { popCoordinator(childCoordinators[indx]) }
//        }
//
//        tabBarController.viewControllers = tabViewControllers
    }

}
