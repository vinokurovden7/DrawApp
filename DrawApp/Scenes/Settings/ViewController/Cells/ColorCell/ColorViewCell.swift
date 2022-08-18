import UIKit

class ColorViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak private var cellView: UIView!
    @IBOutlet weak private var cellLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.cellView.layer.cornerRadius = self.cellView.frame.height / 2
        }
    }

    func setup(for color: String) {
        self.cellLabel.text = color
        self.cellView.backgroundColor = UIColor(named: color)
    }
}
