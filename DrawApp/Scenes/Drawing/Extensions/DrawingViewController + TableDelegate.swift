import UIKit
extension DrawingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drawingViewPresenter?.getCountCells() ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DrawingViewCell.self)
        if let drawingViewPresenter = drawingViewPresenter {
            cell.delegate = drawingViewPresenter
            cell.setup(with: drawingViewPresenter.getCellData(from: indexPath))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? DrawingViewCell {
            drawingViewPresenter?.setDrawing(for: cell.drawingName ?? "")
        }
    }

}
