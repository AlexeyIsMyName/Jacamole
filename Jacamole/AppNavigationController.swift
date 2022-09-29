import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        let font = UIFont(name: "Abel-Regular", size: 18.0)
        let color = UIColor(named: "TextColor")
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [
            .foregroundColor: color ?? .white,
            .font: font ?? .systemFont(ofSize: 18.0)
        ]
        
        self.editButtonItem.tintColor = UIColor(named: "TextColor")
        self.navigationBar.standardAppearance = coloredAppearance
        self.navigationBar.tintColor = .clear
    }
}

