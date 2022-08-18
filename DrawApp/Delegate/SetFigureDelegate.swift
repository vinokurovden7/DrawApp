import UIKit

protocol SetFigureDelegate: AnyObject {
    func setFigureColor(color: String)
    func setFigure(figure: FigureType)
    func selectCell(for indexPath: IndexPath)
    func getSelectedCell() -> [Int: Int?]
}
