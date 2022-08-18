import UIKit

protocol SetDrawingDelegate: AnyObject {
    func setDrawingName(for name: String?)
    func setDrawingImage(for image: UIImage)
}
