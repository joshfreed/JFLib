import Foundation
@testable import JFLib_Date

extension Date {
    static func overrideCurrentDate(_ currentDate: @autoclosure @escaping () -> Date) {
        __date_currentImpl = currentDate
    }
}
