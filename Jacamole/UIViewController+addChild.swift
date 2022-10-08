import UIKit

extension UIViewController {
    
    /// Добавить child VC
    @nonobjc func show(
        viewController: UIViewController,
        in view: UIView
    ) {
        self.addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.view.pinSafeArea(to: view)
        viewController.didMove(toParent: self)
    }
    
    @nonobjc func remove() {
        guard self.parent != nil else { return }
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}
