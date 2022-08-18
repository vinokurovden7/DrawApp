import UIKit

struct DrawingImageModel: Codable {
    var startPoint: CGPoint = .zero
    var endPoint: CGPoint = .zero
    var image: Data = Data()
    var drawingLayer: UInt32 = .zero
}
