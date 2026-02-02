import Foundation

enum SampleData {
    static func makeTimeSeries(days: Int) -> [DataPoint] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let start = calendar.date(byAdding: .day, value: -(days - 1), to: today)!

        var result: [DataPoint] = []
        result.reserveCapacity(days)

        for i in 0..<days {
            let date = calendar.date(byAdding: .day, value: i, to: start)!

            let base = 40.0
            let trend = 0.6 * Double(i)
            let noise = 4.0 * sin(Double(i) * 1.7)
            let value = base + trend + noise
            result.append(DataPoint(date: date, value: value, series: "A"))
        }

        return result
    }
}
