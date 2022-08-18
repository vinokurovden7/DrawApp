import Foundation

class SelectedCell: SelectedCellProtocol {

    private var cellsDictionary: [Int: Int?]

    init(cellsDictionary: [Int: Int?] = [0: nil, 1: nil]) {
        self.cellsDictionary = cellsDictionary
    }

    func selectCell(for indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            cellsDictionary.keys.forEach { key in
                cellsDictionary.removeValue(forKey: key)
            }
            return
        }
        cellsDictionary[indexPath.section] = indexPath.row
    }

    func getSelectedCell() -> [Int: Int?] {
        cellsDictionary
    }
}
