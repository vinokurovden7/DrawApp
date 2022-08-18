import UIKit

class DrawingViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak private var previewImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!

    var drawingName: String?
    weak var delegate: ShareImageDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        previewImage.layer.borderWidth = 1
        previewImage.layer.borderColor = UIColor.black.cgColor
    }

    func setup(with drawingCellModel: DrawingCellModel) {
        if let image = UIImage(data: drawingCellModel.drawingImage) {
            previewImage.image = image
        }
        nameLabel.text = drawingCellModel.drawingName
        drawingName = drawingCellModel.drawingName
    }

    @IBAction func saveImageButtonPressed(_ sender: UIButton) {
        guard let savedImage = previewImage.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(savedImage, nil, nil, nil)
    }

    @IBAction func shareButtonPressed(_ sender: UIButton) {
        guard let image = previewImage.image else {
            return
        }
        delegate?.shareImage(image: image)
    }
}
