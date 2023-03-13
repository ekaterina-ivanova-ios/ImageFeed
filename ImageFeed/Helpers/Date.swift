
import Foundation

extension Date {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_ru")
        return formatter
    }()
    
    var dateTimeString: String { Date.dateFormatter.string(from: self) }
    
    func convertStringToDate(_ string: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: string)
        return date
    }
}
