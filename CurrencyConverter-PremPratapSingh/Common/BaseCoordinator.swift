import UIKit

protocol Coordinator: class {
    func present(with dependencies: ModuleDependencies?)
}

class BaseCoordinator: NSObject, Coordinator {
    weak var delegate: BaseCoordinator?
    weak var parentViewController: BaseViewController?
    
    init(with parentViewController: BaseViewController?) {
        self.parentViewController = parentViewController
    }
    
    func present(with dependencies: ModuleDependencies?) {
        appContext = dependencies?.appContext
    }
    
    func dismiss() {}
    func didDismiss(coordinator: BaseCoordinator) {}
}
