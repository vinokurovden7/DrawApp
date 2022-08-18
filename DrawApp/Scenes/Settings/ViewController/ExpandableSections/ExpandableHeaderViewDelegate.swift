import UIKit

protocol ExpandableHeaderViewDelegate: AnyObject {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}
