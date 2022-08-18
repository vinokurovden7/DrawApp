class DrawingViewCoordinator: Coordinator, DrawingViewRouter {

    private var transitionHandler: TransitionHandler
    private weak var setDrawingDelegate: SetDrawingDelegate?

    init(transitionHandler: TransitionHandler, setDrawingDelegate: SetDrawingDelegate) {
        self.transitionHandler = transitionHandler
        self.setDrawingDelegate = setDrawingDelegate
    }

    func start() {
        let drawingViewController = FactoryScene.defaultSceneFactory.makeDrawingScene(drawingScreenCoordinator: self)
        drawingViewController.drawingViewPresenter?.delegate = setDrawingDelegate
        transitionHandler.push(controller: drawingViewController, animated: true)
    }

    func popViewController() {
        transitionHandler.popController(animated: true)
    }
}
