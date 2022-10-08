import UIKit

class AppTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroungColor")

        setupTB()
        setTabBarAppearance()
    }
    
    func createNavController(for rootViewController: UIViewController,
                                     image: UIImage) -> UIViewController {
        
        let navController = AppNavigationController(rootViewController: rootViewController)
        
        
        navController.tabBarItem.image = image
        let tabBarTitleOffset = UIOffset(horizontal: 0,vertical: 50)
        navController.tabBarItem.titlePositionAdjustment = tabBarTitleOffset

        return navController
    }
    
    private func setupTB() {
        UITabBar.appearance().barTintColor = UIColor(named: "ButtonColor")
        tabBar.backgroundColor = UIColor(named: "BackgroungColor")
        tabBar.barTintColor = UIColor(named: "Color")
        tabBar.layer.backgroundColor = UIColor(named: "Color")?.cgColor
        tabBar.isTranslucent = false
        
    }
    
    private func setTabBarAppearance() {
        let roundLayer = CAShapeLayer()
        let positionOnY: CGFloat = 60.0
        let positionOnX: CGFloat = 5.0
        let width = tabBar.bounds.width + positionOnX * 2
        let height = tabBar.bounds.height + positionOnY

        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: -positionOnX,
                y: tabBar.bounds.minY - 10,
                width: width,
                height: height),
            cornerRadius: height * 10
        )

        roundLayer.path = bezierPath.cgPath
        roundLayer.shadowColor = UIColor.black.cgColor
        roundLayer.shadowOpacity = 2
        roundLayer.shadowOffset = .zero
        roundLayer.shadowRadius = 3
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor(named: "ButtonColor")?.cgColor
        tabBar.tintColor = .systemBlue //UIColor(named: "TextColor")
        tabBar.unselectedItemTintColor = .white
    }
}

