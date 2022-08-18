import UIKit

extension MainViewPresenter {
    func getRectangleFigure(startPoint: CGPoint, endPoint: CGPoint, layer: UInt32) -> Figure {
        let figure = RectacngleFigure(startPoint: startPoint,
                                      endPoint: endPoint,
                                      lineColor: selectedFigure.color ?? "",
                                      fillColor: .clear,
                                      lineWidth: FigureConstant().lineWidth,
                                      drawingLayer: layer)
        return figure
    }

    func getCircleFigure(startPoint: CGPoint, endPoint: CGPoint, layer: UInt32) -> Figure {
        let figure = CircleFigure(startPoint: startPoint,
                                  endPoint: endPoint,
                                  lineColor: selectedFigure.color ?? "",
                                  fillColor: .clear,
                                  lineWidth: FigureConstant().lineWidth,
                                  drawingLayer: layer)
        return figure
    }

    func getTriangleFigure(startPoint: CGPoint, endPoint: CGPoint, layer: UInt32) -> Figure {
        let figure = TriangleFigure(startPoint: startPoint,
                                    endPoint: endPoint,
                                    lineColor: selectedFigure.color ?? "",
                                    fillColor: .clear,
                                    lineWidth: FigureConstant().lineWidth,
                                    drawingLayer: layer)
        return figure
    }

    func getEllipseFigure(startPoint: CGPoint, endPoint: CGPoint, layer: UInt32) -> Figure {
        let figure = EllipseFigure(startPoint: startPoint,
                                   endPoint: endPoint,
                                   lineColor: selectedFigure.color ?? "",
                                   fillColor: .clear,
                                   lineWidth: FigureConstant().lineWidth,
                                   drawingLayer: layer)
        return figure
    }

    func getFigure(startPoint: CGPoint, endPoint: CGPoint, layer: UInt32) -> Figure? {
        guard let figure = selectedFigure.figure else {
            return nil
        }

        switch figure {
        case .rectangle:
            currentFigure = getRectangleFigure(startPoint: startPoint, endPoint: endPoint, layer: layer)
            return currentFigure
        case .circle:
            currentFigure = getCircleFigure(startPoint: startPoint, endPoint: endPoint, layer: layer)
            return currentFigure
        case .triangle:
            currentFigure = getTriangleFigure(startPoint: startPoint, endPoint: endPoint, layer: layer)
            return currentFigure
        case .ellipse:
            currentFigure = getEllipseFigure(startPoint: startPoint, endPoint: endPoint, layer: layer)
            return currentFigure
        }
    }

    func saveFigure() {
        guard let currentFigure = currentFigure else {
            return
        }
        drawnFigures.append(currentFigure)
    }

    func loadFigureInDrawing(for name: String?) {
        let realmfigureData = RealmManager.shared.getDrawing(for: name).figureData
        guard let figureModelsArray = try? JSONDecoder().decode([FigureModel].self, from: realmfigureData) else {
            return
        }
        self.drawnFigures.removeAll()
        figureModelsArray.forEach { figureModel in
            self.selectedFigure.figure = figureModel.figureType
            self.selectedFigure.color = figureModel.figureColorName
            guard let drawnFigure = self.getFigure(startPoint: figureModel.startPoint,
                                                   endPoint: figureModel.endPoint,
                                                   layer: figureModel.drawingLayer) else {
                return
            }
            self.drawnFigures.append(drawnFigure)
        }
    }

    func loadImageInDrawing(for name: String?) {
        let realmImageData = RealmManager.shared.getDrawing(for: name).imageData
        guard let imageModelsArray = try? JSONDecoder().decode([DrawingImageModel].self, from: realmImageData) else {
            return
        }
        self.drawnImages.removeAll()
        imageModelsArray.forEach { imageModel in
            guard let image = UIImage(data: imageModel.image) else {
                return
            }
            self.drawnImages.append(DrawingImage(startPoint: imageModel.startPoint,
                                                 endPoint: imageModel.endPoint,
                                                 image: image,
                                                 drawingLayer: imageModel.drawingLayer))
        }
    }

    func saveDrawing(_ drawing: CALayer, with name: String) {
        DispatchQueue.global().async {
            if let previewImageData = UIImage.imageWithLayer(layer: drawing).compressTo(1600),
               let figureModelData = try? JSONEncoder().encode(self.getFigureModelArray()),
               let imageModelData = try? JSONEncoder().encode(self.getImageModelArray()) {
                let drawing = DrawingModel(drawingName: name,
                                           figureData: figureModelData,
                                           imageData: imageModelData,
                                           previewImage: previewImageData)
                RealmManager.shared.saveDrawing(drawing: drawing)
            }
        }
    }

    func removeObject(at index: Int) {
        drawnFigures.removeAll(where: {
            $0.drawingLayer == UInt32(index)
        })
        drawnFigures.enumerated().forEach { indexImage, drawnImage in
            if drawnImage.drawingLayer > UInt32(index) {
                drawnFigures[indexImage].drawingLayer -= 1
            }
        }

        drawnImages.removeAll(where: {
            $0.drawingLayer == UInt32(index)
        })
        drawnImages.enumerated().forEach { indexImage, drawnImage in
            if drawnImage.drawingLayer > UInt32(index) {
                drawnImages[indexImage].drawingLayer -= 1
            }
        }
    }
}
