import Foundation

public protocol JFServiceResolver {
    func resolve<T>() throws -> T
}
