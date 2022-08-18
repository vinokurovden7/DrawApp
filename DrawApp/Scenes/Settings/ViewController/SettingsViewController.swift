import UIKit

class SettingsViewController: UIViewController,
                              SettingsView,
                              NibLoadable {

    // MARK: Variables
    var settingsScreenPresenter: SettingsViewPreseterProtocol?

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        tableView.register(cellType: FigureViewCell.self)
        tableView.register(cellType: ColorViewCell.self)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.reloadData()

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
    }
}

extension SettingsViewController: ExpandableHeaderViewDelegate {

    func toggleSection(header: ExpandableHeaderView, section: Int) {
        settingsScreenPresenter?.toogleExpandableForSection(section: section)
        tableView.beginUpdates()
        if let settingsScreenPresenter = settingsScreenPresenter {
            settingsScreenPresenter.getSection(for: section).cells.enumerated().forEach { (index, _) in
                self.tableView.reloadRows(at: [IndexPath(row: index, section: section)], with: .automatic)
            }
        }
        tableView.endUpdates()
        if let arrayIndexPath = settingsScreenPresenter?.getSelectedIndexPath() {
            arrayIndexPath.forEach { indexPath in
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }

}
