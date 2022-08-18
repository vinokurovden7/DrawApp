import RealmSwift

class DrawingModel: Object {
    @Persisted var drawingName: String = ""
    @Persisted var figureData: Data = Data()
    @Persisted var imageData: Data = Data()
    @Persisted var previewImage: Data = Data()

    convenience init(drawingName: String,
                     figureData: Data,
                     imageData: Data,
                     previewImage: Data) {
        self.init()
        self.drawingName = drawingName
        self.figureData = figureData
        self.imageData = imageData
        self.previewImage = previewImage
    }

    override class func primaryKey() -> String? {
        return "drawingName"
    }
}
