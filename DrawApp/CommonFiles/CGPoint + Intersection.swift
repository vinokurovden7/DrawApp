import CoreGraphics
extension CGPoint {
    func intersection(firstPoint: CGPoint, secondPoint: CGPoint) -> Bool {
        self.x > firstPoint.x &&
        self.x < secondPoint.x &&
        self.y > firstPoint.y &&
        self.y < secondPoint.y
    }
}
