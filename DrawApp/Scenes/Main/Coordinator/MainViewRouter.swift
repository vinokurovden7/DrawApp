protocol MainViewRouter: AnyObject {
    func navigateToSettingsScreen(setFigureDelegate: SetFigureDelegate)
    func navigateToDrawingScreen(setDrawingDelegate: SetDrawingDelegate)
}
