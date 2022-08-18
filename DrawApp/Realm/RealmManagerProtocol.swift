import RealmSwift

protocol RealmManagerProtocol {
    func saveDrawing(drawing: DrawingModel)
    func getDrawing(for name: String?) -> DrawingModel
    func getAllDrawings() -> [DrawingModel]
}
