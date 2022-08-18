import Foundation

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public typealias NibReusable = Reusable & NibLoadable

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
