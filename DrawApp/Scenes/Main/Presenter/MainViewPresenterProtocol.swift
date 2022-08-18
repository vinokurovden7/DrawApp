import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    var drawnFigures: [Figure] { get }
    var drawnImages: [DrawingImageProtocol] { get }
    var selectedImage: DrawingImageProtocol? { get }
    func viewDidLoad()
    func saveFigure()
    func removeDrawFigure()
    func removeObject(at index: Int)
    func saveDrawing(_ drawing: CALayer, with name: String)
    func loadFigureInDrawing(for name: String?)
    func loadImageInDrawing(for name: String?)
    func settingsBarButtonItemPressed()
    func openDrawingBarButtonItemPressed()
    func setFigure(figure: FigureType)
    func setFigureColor(color: String)
    func getFigure(startPoint: CGPoint, endPoint: CGPoint, layer: UInt32) -> Figure?
    func saveImage()
    func setDrawingImage(for image: UIImage)
    func getDrawingImageView(startPoint: CGPoint, endPoint: CGPoint, layer: UInt32) -> DrawingImageProtocol?
}
