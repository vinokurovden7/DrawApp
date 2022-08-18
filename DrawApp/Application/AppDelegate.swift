import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let transitionHandler = NavigationTransitionHandler(presenter: navigationController)
        let applicationCoordinator = ApplicationCoordinator(transitionHandler: transitionHandler)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window

        applicationCoordinator.start()

        return true
    }
}
