import UIKit

class ApplicationCoordinator: Coordinator {

    private let transitionHandler: TransitionHandler
    private var childCoordinator = [Coordinator]()

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }

    func start() {
        let mainScreenCoordinator = MainViewCoordinator(transitionHandler: transitionHandler)
        childCoordinator.append(mainScreenCoordinator)
        mainScreenCoordinator.start()
    }
}
