import Foundation

struct MyPoint: Hashable {
    var point: Int
}

extension MyPoint {
    static let `default` = MyPoint(point: 0)
}
