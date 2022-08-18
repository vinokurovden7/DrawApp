import UIKit

class MainViewController: UIViewController, MainView {

    // MARK: Variables
    var mainScreenPresenter: MainViewPresenterProtocol?
    let drawLayer = CALayer()
    private var startPanLocation = CGPoint()
    var removeLastFigureButton = UIBarButtonItem()
    private var movedLayer: CALayer?
    private var movedLayerXPos: CGFloat = .zero
    private var movedLayerYPos: CGFloat = .zero

    // MARK: Overrides func
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenPresenter?.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        view.addGestureRecognizer(panGestureRecognizer)
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addRightBarButtonItem()
        addLeftBarButtonItem()
        drawLayer.frame = view.bounds
        drawLayer.backgroundColor = UIColor.white.cgColor
        view.layer.addSublayer(drawLayer)
    }

    // MARK: OBJC func
    @objc
    func settingsBarButtonPressed() {
        mainScreenPresenter?.settingsBarButtonItemPressed()
    }

    @objc
    func restoreDrawing() {
        mainScreenPresenter?.openDrawingBarButtonItemPressed()
    }

    @objc
    func saveDrawingButtonPressed() {
        showSaveDrawingAlert { drawingName in
            self.mainScreenPresenter?.saveDrawing(self.drawLayer, with: drawingName)
        }
    }

    @objc
    func tapGestureAction(_ sender: UITapGestureRecognizer) {
        if removeLastFigureButton.title == BarButtonTitle().endEdit {
            guard let removedLayer = intersectionLayer(location: sender.location(in: view)) else {
                 return
             }

            if let removedIndex = drawLayer.sublayers?.lastIndex(of: removedLayer) {
                mainScreenPresenter?.removeObject(at: removedIndex)
            }
            removedLayer.removeFromSuperlayer()
            if drawLayer.sublayers == nil {
                removeLastFigureButton.title = BarButtonTitle().edit
                removeLastFigureButton.tintColor = .link
            }
            removeLastFigureButton.isEnabled = (drawLayer.sublayers != nil)
        }
    }

    @objc
    func removeLastFigure() {
        if removeLastFigureButton.title == BarButtonTitle().edit {
            removeLastFigureButton.title = BarButtonTitle().endEdit
            removeLastFigureButton.tintColor = .systemRed
        } else {
            removeLastFigureButton.title = BarButtonTitle().edit
            removeLastFigureButton.tintColor = .link
        }
    }

    @objc
    func panGestureAction(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            DispatchQueue.main.async {
                self.startPanLocation = sender.location(in: self.view)
                self.drawObjectOnView(startPoint: self.startPanLocation, endPoint: sender.location(in: self.view))
                if self.removeLastFigureButton.title == BarButtonTitle().endEdit {
                    self.setupMovedLayer(point: sender.location(in: self.view))
                }
            }
        } else if sender.state == .changed {
            if removeLastFigureButton.title == BarButtonTitle().endEdit {
                moveLayer(movingPoint: sender.location(in: self.view))
            } else {
                DispatchQueue.main.async {
                    self.drawLayer.sublayers?.removeLast()
                    self.drawObjectOnView(startPoint: self.startPanLocation, endPoint: sender.location(in: self.view))
                }
            }
        } else if sender.state == .ended {
            saveObjects(startPoint: startPanLocation, enddPoint: sender.location(in: view))
        }
    }

    private func saveObjects(startPoint: CGPoint, enddPoint: CGPoint) {
        mainScreenPresenter?.saveFigure()
        mainScreenPresenter?.saveImage()
    }

    private func intersectionLayer(location: CGPoint) -> CALayer? {
        guard let intersectionLayer = drawLayer.sublayers?.last(where: { layer in
           let startLayerPoint = CGPoint(x: layer.frame.origin.x, y: layer.frame.origin.y)
           let endLayerPoint = CGPoint(x: layer.frame.origin.x + layer.frame.width,
                                       y: layer.frame.origin.y + layer.frame.height)
           return location.intersection(firstPoint: startLayerPoint, secondPoint: endLayerPoint)
        }) else {
            return nil
        }
        return intersectionLayer
    }

    private func setupMovedLayer(point: CGPoint) {
        self.movedLayer = self.intersectionLayer(location: point)
        self.movedLayerXPos = point.x - (self.movedLayer?.frame.origin.x ?? .zero)
        self.movedLayerYPos = point.y - (self.movedLayer?.frame.origin.y ?? .zero)
    }

    private func moveLayer(movingPoint: CGPoint) {
        if let movedLayer = movedLayer {
            DispatchQueue.main.async {
                movedLayer.frame.origin.x = movingPoint.x - self.movedLayerXPos
                movedLayer.frame.origin.y = movingPoint.y - self.movedLayerYPos
            }
        }
    }

}
