import UIKit

class FactoryScene {

    static let defaultSceneFactory = FactoryScene()

    func makeMainScene(mainScreenCoordinator: MainViewRouter) -> MainViewController {

        let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let identifier = String(describing: type(of: MainViewController()))

        guard let mainViewController = storyboard
                .instantiateViewController(identifier: identifier) as? MainViewController else {
            return MainViewController()
        }
        let mainViewModel = MainViewModel()
        mainViewController.title = "Main"
        mainViewController.mainScreenPresenter = MainViewPresenter(
                                                    viewController: mainViewController,
                                                    viewModel: mainViewModel,
                                                    mainScreenCoordinator: mainScreenCoordinator)

        return mainViewController
    }

    func makeSettingsScene() -> SettingsViewController {

        let storyboard = UIStoryboard(name: "SettingsScreen", bundle: nil)
        let identifier = String(describing: type(of: SettingsViewController()))

        guard let settingsViewController = storyboard
                .instantiateViewController(identifier: identifier) as? SettingsViewController else {
            return SettingsViewController()
        }
        settingsViewController.title = "Settings"
        settingsViewController.settingsScreenPresenter = SettingsViewPreseter()

        return settingsViewController
    }

    func makeDrawingScene(drawingScreenCoordinator: DrawingViewRouter) -> DrawingViewController {

        let storyboard = UIStoryboard(name: "Drawing", bundle: nil)
        let identifier = String(describing: type(of: DrawingViewController()))

        guard let drawingViewController = storyboard
                .instantiateViewController(withIdentifier: identifier) as? DrawingViewController else {
            return DrawingViewController()
        }

        drawingViewController.title = "Saved drawing"
        drawingViewController.drawingViewPresenter = DrawingViewPresenter(
                                                        drawingScreenCoordinator: drawingScreenCoordinator,
                                                        viewController: drawingViewController)
        return drawingViewController

    }

}
