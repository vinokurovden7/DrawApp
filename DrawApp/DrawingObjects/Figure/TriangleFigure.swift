import UIKit

struct TriangleFigure: Figure {

    var figureType: FigureType
    var startPoint: CGPoint
    var endPoint: CGPoint
    var fillColor: CGColor
    var lineColor: String
    var lineWidth: CGFloat
    var drawingLayer: UInt32

    init(startPoint: CGPoint = .zero,
         endPoint: CGPoint = .zero,
         lineColor: String = "",
         fillColor: UIColor = .clear,
         lineWidth: CGFloat = 1.0,
         drawingLayer: UInt32 = .zero) {

        figureType = .triangle
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.lineColor = lineColor
        self.fillColor = fillColor.cgColor
        self.lineWidth = lineWidth
        self.drawingLayer = drawingLayer
    }

    func getPath(on layer: CALayer) -> CGPath {
        let freeform = CGMutablePath()
        let endPoint = CGPoint(x: layer.frame.width, y: layer.frame.height)
        freeform.move(to: CGPoint(x: .zero + ((endPoint.x - .zero) / 2), y: .zero))
        freeform.addLine(to: endPoint)
        freeform.addLine(to: CGPoint(x: .zero, y: endPoint.y))
        freeform.closeSubpath()
        return freeform
    }

}
