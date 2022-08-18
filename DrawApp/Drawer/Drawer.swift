import UIKit

public class Drawer: DrawerProtocol {

    private let shapeLayer: CAShapeLayer = CAShapeLayer()

    func draw(on layer: CALayer, figure: Figure) {
        let newDrawLayer = CALayer()
        newDrawLayer.frame.origin = figure.checkPoints().startPoint
        newDrawLayer.frame.size = CGSize(width: abs(figure.checkPoints().startPoint.x - figure.checkPoints().endPoint.x),
                                         height: abs(figure.checkPoints().startPoint.y - figure.checkPoints().endPoint.y))
        newDrawLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.path = figure.getPath(on: newDrawLayer)
        shapeLayer.fillColor = figure.fillColor
        shapeLayer.strokeColor = UIColor(named: figure.lineColor)?.cgColor
        shapeLayer.lineWidth = figure.lineWidth
        shapeLayer.backgroundColor = UIColor.red.cgColor
        newDrawLayer.addSublayer(shapeLayer)
        layer.addSublayer(newDrawLayer)
    }

    func draw(on layer: CALayer, drawingImageView: DrawingImageProtocol?) {
        guard let drawingImageView = drawingImageView else {
            return
        }
        let widthFrame: CGFloat = abs(drawingImageView.checkPoints().startPoint.x - drawingImageView.checkPoints().endPoint.x)
        let heightFrame: CGFloat = abs(drawingImageView.checkPoints().startPoint.y - drawingImageView.checkPoints().endPoint.y)
        let newDrawLayer = CALayer()
        newDrawLayer.frame.origin = drawingImageView.checkPoints().startPoint
        newDrawLayer.frame.size = CGSize(width: widthFrame, height: heightFrame)
        newDrawLayer.backgroundColor = UIColor.red.cgColor
        newDrawLayer.contents = drawingImageView.image
        layer.insertSublayer(newDrawLayer, at: drawingImageView.drawingLayer)
    }
}
