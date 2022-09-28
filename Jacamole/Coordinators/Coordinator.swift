import UIKit

class Coordinator: NSObject {
    
    /// Notify parent coordinator that this subflow has finished
    var didFinish: ((Coordinator) -> ())?
    var childCoordinators = [Coordinator]()
    private(set) var rootViewController: UIViewController?

    func start() {}

    // MARK: - Deinitialization
    deinit {
        print("\(type(of: self)) deinit")
    }
    
}

// MARK: - Helper Methods
extension Coordinator {
    
    func pushCoordinator(_ coordinator: Coordinator) {
        coordinator.didFinish = { [weak self] coordinator in
            self?.popCoordinator(coordinator)
        }
        
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func popCoordinator(_ coordinator: Coordinator) {
        // Remove Coordinator From Child Coordinators
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
}

extension Coordinator: UINavigationControllerDelegate {
    
    // MARK: - For notifying child coordinators
    // MARK: Default implementation for this methods. If child coordinators don't need them - they don't have to impl them.
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {}

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
    
}
