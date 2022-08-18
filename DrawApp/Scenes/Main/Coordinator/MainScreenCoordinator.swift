import UIKit

class MainViewCoordinator: Coordinator, MainViewRouter {

    private var transitionHandler: TransitionHandler

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }

    func start() {
        let mainViewController = FactoryScene
                                    .defaultSceneFactory
                                    .makeMainScene(mainScreenCoordinator: self)

        transitionHandler.push(controller: mainViewController, animated: true)
    }

    func navigateToSettingsScreen() {
        let settingsScreenCoordinator = SettingsViewCoordinator(
                                            transitionHandler: transitionHandler)
        settingsScreenCoordinator.start()
    }

}
