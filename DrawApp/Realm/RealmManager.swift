import RealmSwift

// swiftlint:disable implicitly_unwrapped_optional
class RealmManager: RealmManagerProtocol {

    static let shared = RealmManager()
    private let realm: Realm!

    private init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func saveDrawing(drawing: DrawingModel) {

        autoreleasepool {
            do {
                let realmBackground = try Realm()
                try realmBackground.write {
                    realmBackground.add(drawing, update: .modified)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getDrawing(for name: String?) -> DrawingModel {

        autoreleasepool {
            do {
                let realmBackground = try Realm()
                if let name = name {
                    guard let drawingModelObject = realmBackground.objects(DrawingModel.self).first(where: {
                        $0.drawingName == name
                    }) else {
                        return DrawingModel()
                    }
                    return drawingModelObject
                }

                guard let drawingModelObject = realmBackground.objects(DrawingModel.self).first else {
                    return DrawingModel()
                }
                return drawingModelObject
            } catch {
                return DrawingModel()
            }
        }
    }

    func getAllDrawings() -> [DrawingModel] {
        autoreleasepool {
            do {
                let realmBackground = try Realm()
                let drawingModelObject = realmBackground.objects(DrawingModel.self).sorted(byKeyPath: "drawingName")
                var drawings = [DrawingModel]()
                drawingModelObject.forEach { drawing in
                    drawings.append(drawing)
                }
                return drawings
            } catch {
                return []
            }
        }
    }

}
