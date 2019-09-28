import UIKit

protocol ViewDelegate: BaseViewController {}

class BaseViewModel {
    weak var viewDelegate: ViewDelegate!
    var dependencies: ModuleDependencies?
    
    init(delegate: ViewDelegate, dependencies: ModuleDependencies?) {
        self.viewDelegate = delegate
        self.dependencies = dependencies
    }
}
