import UIKit

class FigureViewCell: UITableViewCell, NibReusable {

    private var figureType: FigureType?
    private let figureLayer = CALayer()

    @IBOutlet weak private var cellView: UIView!
    @IBOutlet weak private var cellLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.drawFigureOnView()
        }
    }

    func setup(for figureType: FigureType) {
        cellLabel.text = figureType.rawValue
        cellView.backgroundColor = .clear
        self.figureType = figureType
    }

    private func drawFigureOnView() {
        figureLayer.frame = cellView.bounds
        cellView.layer.addSublayer(figureLayer)
        guard let figureType = figureType else {
            return
        }
        figureLayer.sublayers?.removeAll()
        Drawer().draw(on: figureLayer, figure: getFigure(figureType))
    }

    private func getFigure(_ figureType: FigureType) -> Figure {
        switch figureType {
        case .rectangle:
            return getRectangleFigure()
        case .circle:
            return getCircleFigure()
        case .triangle:
            return getTriangleFigure()
        case .ellipse:
            return getEllipseFigure()
        }
    }

    private func getRectangleFigure() -> Figure {
        let endPoint = CGPoint(x: cellView.frame.width, y: cellView.frame.height)
        let figure = RectacngleFigure(endPoint: endPoint,
                                      lineColor: FigureConstant().lineColor,
                                      lineWidth: FigureConstant().lineWidth)
        return figure
    }

    private func getCircleFigure() -> Figure {
        let endPoint = CGPoint(x: cellView.frame.width, y: cellView.frame.height)
        let figure = CircleFigure(endPoint: endPoint,
                                  lineColor: FigureConstant().lineColor,
                                  lineWidth: FigureConstant().lineWidth)
        return figure
    }

    private func getTriangleFigure() -> Figure {
        let endPoint = CGPoint(x: cellView.frame.width, y: cellView.frame.height)
        let figure = TriangleFigure(endPoint: endPoint,
                                    lineColor: FigureConstant().lineColor,
                                    lineWidth: FigureConstant().lineWidth)
        return figure
    }

    private func getEllipseFigure() -> Figure {
        let ellipseEndPoint = CGPoint(x: (cellView.frame.width - cellView.frame.width / FigureConstant().ellipseXDivider),
                                      y: cellView.frame.height)
        let figure = EllipseFigure(startPoint: CGPoint(x: cellView.frame.width / FigureConstant().ellipseXDivider,
                                                       y: .zero),
                                   endPoint: ellipseEndPoint,
                                   lineColor: FigureConstant().lineColor,
                                   lineWidth: FigureConstant().lineWidth)
        return figure
    }

}
