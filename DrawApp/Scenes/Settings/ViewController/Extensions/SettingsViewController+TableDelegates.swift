import UIKit

extension SettingsViewController: UITableViewDelegate,
                                  UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        settingsScreenPresenter?.getCountSection() ?? .zero
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsScreenPresenter?.getCountCellsInSection(section: section) ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch settingsScreenPresenter?.getCell(for: indexPath) {
        case .color(let color):
            let dequeueCell = tableView.dequeueReusableCell(for: indexPath, cellType: ColorViewCell.self)
            dequeueCell.setup(for: color)
            return dequeueCell
        case .figure(let figure):
            let dequeueCell = tableView.dequeueReusableCell(for: indexPath, cellType: FigureViewCell.self)
            dequeueCell.setup(for: figure)
            return dequeueCell
        case .none:
            return UITableViewCell()
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let deselectIndexPath = settingsScreenPresenter?.selectIndexPath(indexPath: indexPath) {
            if deselectIndexPath != indexPath {
                tableView.deselectRow(at: deselectIndexPath, animated: true)
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let selectIndexPath = settingsScreenPresenter?.selectIndexPath(indexPath: indexPath) {
            tableView.selectRow(at: selectIndexPath, animated: true, scrollPosition: .none)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SettingsTableViewConstant().heightForHeaderInSection
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if settingsScreenPresenter?.sectionIsExpanded(section: indexPath.section) ?? false {
            return SettingsTableViewConstant().heightForRowAt
        }
        return .zero
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SettingsTableViewConstant().heightForFooterInSection
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.setup(title: settingsScreenPresenter?.getSection(for: section).sectionName ?? "",
                     section: section,
                     delegate: self)
        return header
    }

}
