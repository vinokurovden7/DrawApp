import UIKit

class ExpandableHeaderView: UITableViewHeaderFooterView {
    weak var delegate: ExpandableHeaderViewDelegate?
    var section: Int?

    func setup(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.textColor = .white
        contentView.backgroundColor = .darkGray

    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHeaderAction))
        addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc
    func tappedHeaderAction(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? ExpandableHeaderView else {
            return
        }

        guard let section = cell.section else {
            return
        }

        delegate?.toggleSection(header: self, section: section)
    }
}
