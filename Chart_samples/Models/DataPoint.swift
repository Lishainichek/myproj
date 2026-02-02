
import Foundation

struct DataPoint: Identifiable, Equatable {
    let id: String
    let date: Date
    let value: Double
    let series: String

    init(date: Date, value: Double, series: String) {
        self.date = date
        self.value = value
        self.series = series
        self.id = "\(series)-\(Int(date.timeIntervalSince1970))"
    }
}
