import Foundation

protocol SelectedCellProtocol {
    func selectCell(for indexPath: IndexPath?)
    func getSelectedCell() -> [Int: Int?]
}
