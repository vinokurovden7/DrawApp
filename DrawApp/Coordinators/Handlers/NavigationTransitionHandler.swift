import UIKit

class NavigationTransitionHandler: TransitionHandler {

    private var presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func present(controller: UIViewController, animated: Bool = true) {
        presenter.present(controller, animated: animated, completion: nil)
    }

    func push(controller: UIViewController, animated: Bool = true) {
        presenter.pushViewController(controller, animated: animated)
    }

    func popController(animated: Bool = true) {
        presenter.popViewController(animated: animated)
    }

    func dismissController(animated: Bool = true) {
        presenter.dismiss(animated: animated, completion: nil)
    }

}
