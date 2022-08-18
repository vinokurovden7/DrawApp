import UIKit

struct CircleFigure: Figure {

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

        figureType = .circle
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
        size = layer.frame.height > layer.frame.width ?
            CGSize(width: layer.frame.width, height: layer.frame.width) :
            CGSize(width: layer.frame.height, height: layer.frame.height)
        mutablePath.addEllipse(in: CGRect(origin: .zero, size: size), transform: .identity)
        return mutablePath
    }
}
