import UIKit

class SettingsViewCoordinator: Coordinator, SettingsViewRouter {

    private let transitionHandler: TransitionHandler
    private weak var setFigureDelegate: SetFigureDelegate?

    init(transitionHandler: TransitionHandler, setFigureDelegate: SetFigureDelegate) {
        self.transitionHandler = transitionHandler
        self.setFigureDelegate = setFigureDelegate
    }

    func start() {
        let settingsViewController = FactoryScene
                                    .defaultSceneFactory
                                    .makeSettingsScene()
        settingsViewController.settingsScreenPresenter?.delegate = setFigureDelegate
        transitionHandler.push(controller: settingsViewController, animated: true)
    }

}
