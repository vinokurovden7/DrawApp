import UIKit

struct DrawingImage: DrawingImageProtocol {

    var startPoint: CGPoint
    var endPoint: CGPoint
    var image: CGImage?
    var drawingLayer: UInt32

    init(startPoint: CGPoint = .zero,
         endPoint: CGPoint = .zero,
         image: UIImage,
         drawingLayer: UInt32 = .zero) {

        self.startPoint = startPoint
        self.endPoint = endPoint
        self.image = image.cgImage
        self.drawingLayer = drawingLayer
    }

    func getImageView(on layer: CALayer) -> UIImageView {
        var size = CGSize()
        size = CGSize(width: layer.frame.width, height: layer.frame.height)
        let drawingImageViewFrame = CGRect(origin: .zero, size: size)
        let drawingImageView = UIImageView(frame: drawingImageViewFrame)
        if let image = image {
            drawingImageView.image = UIImage(cgImage: image)
            drawingImageView.contentMode = .scaleAspectFit
        }
        return drawingImageView
    }

}
