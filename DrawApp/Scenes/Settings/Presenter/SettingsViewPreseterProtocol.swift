import Foundation

protocol SettingsViewPreseterProtocol: AnyObject {
    var delegate: SetFigureDelegate? { get set }
    func getSelectedIndexPath() -> [IndexPath]
    func getCountSection() -> Int
    func getCountCellsInSection(section: Int) -> Int
    func getSection(for section: Int) -> Section
    func sectionIsExpanded(section: Int) -> Bool
    func toogleExpandableForSection(section: Int)
    func getCell(for indexPath: IndexPath) -> Cell
    func selectIndexPath(indexPath: IndexPath) -> IndexPath?
}
