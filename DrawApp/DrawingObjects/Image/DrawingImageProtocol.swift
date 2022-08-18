import UIKit
protocol DrawingImageProtocol {
    var startPoint: CGPoint { get set }
    var endPoint: CGPoint { get set }
    var image: CGImage? { get }
    var drawingLayer: UInt32 { get set }
    func checkPoints() -> (startPoint: CGPoint, endPoint: CGPoint)
}

extension DrawingImageProtocol {
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
