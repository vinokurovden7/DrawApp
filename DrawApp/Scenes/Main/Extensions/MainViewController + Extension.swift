import UIKit

extension MainViewController {
    func addRightBarButtonItem() {
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(settingsBarButtonPressed))
        removeLastFigureButton = UIBarButtonItem(title: "Edit",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(removeLastFigure))

        navigationItem.rightBarButtonItems = [settingsBarButtonItem, removeLastFigureButton]
    }

    func addLeftBarButtonItem() {
        let restoreButton = UIBarButtonItem(image: UIImage(systemName: "tray.and.arrow.up"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(restoreDrawing))
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "tray.and.arrow.down"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveDrawingButtonPressed))

        navigationItem.leftBarButtonItems = [restoreButton, saveButton]
    }

    func drawObjectOnView(startPoint: CGPoint, endPoint: CGPoint) {
        let lastIndexSublayer = UInt32(drawLayer.sublayers?.count ?? 0)
        if let mainScreenPresenter = mainScreenPresenter {
            if let drawImageView = mainScreenPresenter
                .getDrawingImageView(startPoint: startPoint,
                                     endPoint: endPoint,
                                     layer: lastIndexSublayer) {
                Drawer().draw(on: drawLayer, drawingImageView: drawImageView)
                removeLastFigureButton.isEnabled = (drawLayer.sublayers != nil)
                return
            }
            guard let figure = mainScreenPresenter.getFigure(startPoint: startPoint,
                                                             endPoint: endPoint, layer: lastIndexSublayer) else {
                return
            }
            Drawer().draw(on: drawLayer, figure: figure)
            removeLastFigureButton.isEnabled = (drawLayer.sublayers != nil)
        }
    }

    func loadDrawing() {
        if drawLayer.sublayers == nil {
            guard let mainScreenPresenter = mainScreenPresenter else {
                return
            }
            mainScreenPresenter.drawnFigures.forEach { figure in
                Drawer().draw(on: drawLayer, figure: figure)
            }
            mainScreenPresenter.drawnImages.forEach { image in
                Drawer().draw(on: drawLayer, drawingImageView: image)
            }
            removeLastFigureButton.isEnabled = (drawLayer.sublayers != nil)
        }
    }

    func clearDrawing() {
        drawLayer.sublayers?.removeAll()
    }
}
