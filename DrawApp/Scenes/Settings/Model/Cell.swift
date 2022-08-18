import UIKit

enum Cell {
    case figure(FigureType)
    case color(String)

    var cellTitle: String {
        switch self {
        case .color(let color):
            return color
        case .figure(let figure):
            return figure.rawValue
        }
    }
}
