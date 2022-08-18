import UIKit

protocol DrawingViewPresenterProtocol: ShareImageDelegate {
    var delegate: SetDrawingDelegate? { get set }
    func getCountCells() -> Int
    func getCellData(from indedxPath: IndexPath) -> DrawingCellModel
    func setDrawing(for name: String)
    func setDrawing(for image: UIImage)
    func shareImage(image: UIImage)
}
