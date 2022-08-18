import UIKit

struct RectacngleFigure: Figure {

    var figureType: FigureType
    var startPoint: CGPoint
    var endPoint: CGPoint
    var lineColor: String
    var fillColor: CGColor
    var lineWidth: CGFloat
    var drawingLayer: UInt32

    init(startPoint: CGPoint = .zero,
         endPoint: CGPoint = .zero,
         lineColor: String = "",
         fillColor: UIColor = .clear,
         lineWidth: CGFloat = 1.0,
         drawingLayer: UInt32 = .zero) {

        figureType = .rectangle
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.lineColor = lineColor
        self.fillColor = fillColor.cgColor
        self.lineWidth = lineWidth
        self.drawingLayer = drawingLayer
    }

    func getPath(on layer: CALayer) -> CGPath {
        let mutablePath = CGMutablePath()
        var size = CGSize()
        size = CGSize(width: layer.frame.width, height: layer.frame.height)
        mutablePath.addRect(CGRect(origin: .zero, size: size), transform: .identity)
        return mutablePath
    }
}
