import UIKit

class SettingsViewPreseter: SettingsViewPreseterProtocol {
    private var sectionObjects = [Section]()
    weak var delegate: SetFigureDelegate?
    private lazy var selectedIndexPath = delegate?.getSelectedCell()

    init() {
        addFigures()
        addColors()
    }

    func getCountSection() -> Int {
        return sectionObjects.count
    }

    func getCountCellsInSection(section: Int) -> Int {
        sectionObjects[section].cells.count
    }

    func getSection(for section: Int) -> Section {
        sectionObjects[section]
    }

    func getCell(for indexPath: IndexPath) -> Cell {
        return sectionObjects[indexPath.section].cells[indexPath.row]
    }

    func sectionIsExpanded(section: Int) -> Bool {
        sectionObjects[section].expanded
    }

    func toogleExpandableForSection(section: Int) {
        sectionObjects[section].expanded = !sectionObjects[section].expanded
    }

    private func addFigures() {
        let figures = Section(sectionName: "Figure",
                              cells: [
                                .figure(.rectangle),
                                .figure(.circle),
                                .figure(.triangle),
                                .figure(.ellipse)
                              ],
                              expanded: false)
        sectionObjects.append(figures)
    }

    private func addColors() {
        let colors = Section(sectionName: "Color",
                             cells: [
                                .color("blackColor"),
                                .color("redColor"),
                                .color("blueColor"),
                                .color("purpleColor"),
                                .color("yellowColor"),
                                .color("greenColor"),
                                .color("orangeColor")
                             ],
                             expanded: false)
        sectionObjects.append(colors)
    }

    func selectIndexPath(indexPath: IndexPath) -> IndexPath? {
        setFigure(for: indexPath)
        if selectedIndexPath?[indexPath.section] != nil {
            if let deselectRow = selectedIndexPath?.removeValue(forKey: indexPath.section) {
                selectedIndexPath?[indexPath.section] = indexPath.row
                if let deselectRow = deselectRow {
                    let deselectIndexPath = IndexPath(row: deselectRow, section: indexPath.section)
                    return deselectIndexPath
                }
                return nil
            } else {
                return nil
            }
        } else {
            selectedIndexPath?[indexPath.section] = indexPath.row
            return nil
        }
    }

    private func setFigure(for indexPath: IndexPath) {
        delegate?.selectCell(for: indexPath)
        switch sectionObjects[indexPath.section].cells[indexPath.row] {
        case .figure(let figure):
            self.delegate?.setFigure(figure: figure)
        case .color(let color):
            self.delegate?.setFigureColor(color: color)
        }
    }

    func getSelectedIndexPath() -> [IndexPath] {
        var indexPathArray = [IndexPath]()
        if let selecteddIndexPath = selectedIndexPath {
            for itemDictionary in selecteddIndexPath {
                if let item = itemDictionary.value {
                    indexPathArray.append(IndexPath(item: item,
                                                    section: itemDictionary.key))
                }
            }
        }
        return indexPathArray
    }

}
