import UIKit

protocol Figure {
    var figureType: FigureType { get }
    var startPoint: CGPoint { get }
    var endPoint: CGPoint { get }
    var fillColor: CGColor { get }
    var lineColor: String { get }
    var lineWidth: CGFloat { get }
    var drawingLayer: UInt32 { get set }
    func getPath(on layer: CALayer) -> CGPath
    func checkPoints() -> (startPoint: CGPoint, endPoint: CGPoint)
}

extension Figure {
    func checkPoints() -> (startPoint: CGPoint, endPoint: CGPoint) {
        var newStartPoint = startPoint
        var newEndPoint = endPoint

        if startPoint.x > endPoint.x && startPoint.y > endPoint.y {
            newStartPoint = endPoint
            newEndPoint = startPoint
        } else if startPoint.x > endPoint.x && startPoint.y < endPoint.y {
            newStartPoint = CGPoint(x: endPoint.x, y: startPoint.y)
            newEndPoint = CGPoint(x: startPoint.x, y: endPoint.y)
        } else if startPoint.y > endPoint.y && startPoint.x < endPoint.x {
            newStartPoint = CGPoint(x: startPoint.x, y: endPoint.y)
            newEndPoint = CGPoint(x: endPoint.x, y: startPoint.y)
        }

        return (newStartPoint, newEndPoint)
    }
}
