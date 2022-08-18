import UIKit
import RealmSwift

class MainViewPresenter: MainViewPresenterProtocol,
                         SetFigureDelegate,
                         SetDrawingDelegate {

    let viewController: MainView
    let viewModel: MainViewModelProtocol
    var mainScreenCoordinator: MainViewRouter
    var selectedFigure: SelectedFigure
    var drawnFigures = [Figure]()
    var drawnImages = [DrawingImageProtocol]()
    var selectedImage: DrawingImageProtocol?
    var currentFigure: Figure?
    let dispatchGroup = DispatchGroup()
    private let selectedCell: SelectedCellProtocol

    init(viewController: MainView,
         viewModel: MainViewModelProtocol,
         mainScreenCoordinator: MainViewRouter) {
        self.viewController = viewController
        self.viewModel = viewModel
        self.mainScreenCoordinator = mainScreenCoordinator
        self.selectedCell = SelectedCell()
        self.selectedFigure = SelectedFigure()
    }

    func viewDidLoad() {
        setDrawingName(for: nil)
    }

    func setFigure(figure: FigureType) {
        selectedFigure.figure = figure
        selectedImage = nil
    }

    func removeDrawFigure() {
        drawnFigures.removeAll()
    }

    func setFigureColor(color: String) {
        selectedFigure.color = color
    }

    func selectCell(for indexPath: IndexPath) {
        selectedCell.selectCell(for: indexPath)
    }

    func getSelectedCell() -> [Int: Int?] {
        selectedCell.getSelectedCell()
    }

    func settingsBarButtonItemPressed() {
        mainScreenCoordinator.navigateToSettingsScreen(setFigureDelegate: self)
    }

    func openDrawingBarButtonItemPressed() {
        mainScreenCoordinator.navigateToDrawingScreen(setDrawingDelegate: self)
    }

    func saveImage() {
        guard let savedImage = selectedImage else {
            return
        }
        drawnImages.append(savedImage)
    }

    func setDrawingName(for name: String?) {
        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.loadImageInDrawing(for: name)
            self.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.loadFigureInDrawing(for: name)
            self.dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.viewController.clearDrawing()
            self.viewController.loadDrawing()
        }
    }

    func setDrawingImage(for image: UIImage) {
        selectedImage = DrawingImage(image: image)
        selectedCell.selectCell(for: nil)
        selectedFigure = SelectedFigure(figure: nil, color: nil)
    }

    func getDrawingImageView(startPoint: CGPoint, endPoint: CGPoint, layer: UInt32) -> DrawingImageProtocol? {
        selectedImage?.startPoint = startPoint
        selectedImage?.endPoint = endPoint
        selectedImage?.drawingLayer = layer
        return selectedImage
    }

    func getImageModelArray() -> [DrawingImageModel] {
        let tempDrawnImages = drawnImages
        var imageModelArray = [DrawingImageModel]()
        tempDrawnImages.forEach { drawnImage in
            guard let drawnCgImage = drawnImage.image else {
                return
            }
            guard let image = UIImage(cgImage: drawnCgImage).compressTo(1600 / drawnImages.count) else {
                return
            }
            let imageModel = DrawingImageModel(startPoint: drawnImage.startPoint,
                                               endPoint: drawnImage.endPoint,
                                               image: image,
                                               drawingLayer: drawnImage.drawingLayer)
            imageModelArray.append(imageModel)
        }
        return imageModelArray
    }

    func getFigureModelArray() -> [FigureModel] {
        let tempDrawnFigures = drawnFigures
        var figureModelArray = [FigureModel]()
        tempDrawnFigures.forEach { drawnFigure in
            let figureModel = FigureModel(figureType: drawnFigure.figureType,
                                          figureColorName: drawnFigure.lineColor,
                                          startPoint: drawnFigure.startPoint,
                                          endPoint: drawnFigure.endPoint,
                                          drawingLayer: drawnFigure.drawingLayer)
            figureModelArray.append(figureModel)
        }
        return figureModelArray
    }
}
