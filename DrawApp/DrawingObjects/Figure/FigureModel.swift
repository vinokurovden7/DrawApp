import UIKit

struct FigureModel: Codable {
    var figureType: FigureType = .rectangle
    var figureColorName: String = ""
    var startPoint: CGPoint = .zero
    var endPoint: CGPoint = .zero
    var drawingLayer: UInt32 = .zero
}
