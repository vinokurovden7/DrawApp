import UIKit

class DrawingViewPresenter: DrawingViewPresenterProtocol,
                            ShareImageDelegate {

    weak var delegate: SetDrawingDelegate?
    private var drawingScreenCoordinator: DrawingViewRouter
    private var viewController: DrawingView
    private var presenterDispatchGroup = DispatchGroup()

    init(drawingScreenCoordinator: DrawingViewRouter, viewController: DrawingView) {
        self.drawingScreenCoordinator = drawingScreenCoordinator
        self.viewController = viewController
    }

    func getCountCells() -> Int {
        var countCell: Int = .zero
        presenterDispatchGroup.enter()
        DispatchQueue.global().async {
            countCell = RealmManager.shared.getAllDrawings().count
            self.presenterDispatchGroup.leave()
        }
        presenterDispatchGroup.wait()
        return countCell
    }

    func getCellData(from indedxPath: IndexPath) -> DrawingCellModel {
        var drawing = [DrawingModel]()
        var drawingCellModel = DrawingCellModel(drawingName: "", drawingImage: Data())
        presenterDispatchGroup.enter()
        DispatchQueue.global().async {
            drawing = RealmManager.shared.getAllDrawings()
            drawingCellModel = DrawingCellModel(drawingName: drawing[indedxPath.row].drawingName,
                                                    drawingImage: drawing[indedxPath.row].previewImage)
            self.presenterDispatchGroup.leave()
        }
        presenterDispatchGroup.wait()
        return drawingCellModel
    }

    func setDrawing(for name: String) {
        delegate?.setDrawingName(for: name)
        drawingScreenCoordinator.popViewController()
    }

    func setDrawing(for image: UIImage) {
        delegate?.setDrawingImage(for: image)
        drawingScreenCoordinator.popViewController()
    }

    func shareImage(image: UIImage) {
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        activityViewController.excludedActivityTypes = [ .airDrop, .mail, .message]
        viewController.present(activityViewController, animated: true, completion: nil)
    }
}
