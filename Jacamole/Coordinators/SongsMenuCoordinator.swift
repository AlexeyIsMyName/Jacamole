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
            [weak self] section, sectionTitle in
            self?.showOlolo(section: section, sectionTitle: sectionTitle)
        }
        
        navigationController.pushViewController(songsMenuVC, animated: false)
    }
    
    func showOlolo(section: Int, sectionTitle: String) {
        let vc = SongsListViewController(navigationTitle: sectionTitle, iNeedSearchBar: true, iNeedCloseButton: true)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}

