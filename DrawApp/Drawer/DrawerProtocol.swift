import UIKit

protocol DrawerProtocol {
    func draw(on layer: CALayer, figure: Figure)
    func draw(on layer: CALayer, drawingImageView: DrawingImageProtocol?)
}
