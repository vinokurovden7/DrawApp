import UIKit
import RealmSwift
import PhotosUI

class DrawingViewController: UIViewController, DrawingView {

    // MARK: IBOutlets
    @IBOutlet weak private var tableView: UITableView!

    // MARK: Variable and constants
    var drawingViewPresenter: DrawingViewPresenterProtocol?

    // MARK: Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addRightButtonItem()
    }

    // MARK: custom methods
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellType: DrawingViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func addRightButtonItem() {
        let importPhotoButton = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle.angled"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(importPhotoButtonPressed))
        navigationItem.rightBarButtonItems = [importPhotoButton]
    }

    func reloadTable() {
        tableView.reloadData()
    }

    // MARK: Objc methods
    @objc
    private func importPhotoButtonPressed() {
        let requiredAccessLevel: PHAccessLevel = .readWrite
        PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { (authorizationStatus) in
            switch authorizationStatus {
            case .authorized, .limited:
                DispatchQueue.main.async {
                    self.presentImagePicker()
                }
            default:
                break
            }
        }
    }

    private func presentImagePicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        DispatchQueue.main.async {
            self.present(picker, animated: true)
        }
    }
}

extension DrawingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            let provider = result.itemProvider

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    guard let image = image as? UIImage else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.drawingViewPresenter?.setDrawing(for: image)
                    }
                }
            }
        }
    }
}
