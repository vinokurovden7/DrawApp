import UIKit

protocol TransitionHandler: AnyObject {
    func present(controller: UIViewController, animated: Bool)
    func push(controller: UIViewController, animated: Bool)
    func popController(animated: Bool)
    func dismissController(animated: Bool)
}
