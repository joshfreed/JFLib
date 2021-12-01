import Foundation

@propertyWrapper
public class Injected<T> {
    private var service: T?

    public var wrappedValue: T {
        get {
            if service == nil {
                service = try? JFServices.resolve()
            }
            return service!
        }

        set { service = newValue }
    }

    public init() {}
}
