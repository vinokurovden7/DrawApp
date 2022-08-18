import UIKit

extension UIViewController {
    func showSaveDrawingAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Save drawing",
                                      message: "Please, enter drawing name from saving",
                                      preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let drawingName = alert.textFields?[0].text else {
                return
            }
            completion(drawingName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        alert.addTextField { textField in
            textField.placeholder = "Name drawing"
        }
        alert.addAction(okAlertAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }

    func showRestoreDrawingAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Restore drawing",
                                      message: "Please, enter drawing name from open",
                                      preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Open", style: .default) { _ in
            guard let drawingName = alert.textFields?[0].text else {
                return
            }
            completion(drawingName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        alert.addTextField { textField in
            textField.placeholder = "Name drawing"
        }
        alert.addAction(okAlertAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
