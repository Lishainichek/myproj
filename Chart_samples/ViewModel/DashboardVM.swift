import Foundation
import Combine

final class DashboardVM: ObservableObject {
    enum RangeMode: String, CaseIterable {
        case d7 = "7d"
        case d30 = "30d"
    }

    @Published var mode: RangeMode = .d30
    @Published var selectedSeriesForBars: String = "A"

    private let allData: [DataPoint] = SampleData.makeTimeSeries(days: 30)

    var data: [DataPoint] {
        let k = 30
        return Array(allData.suffix(k * 2))
    }

    var yDomain: ClosedRange<Double> {
        let vals = data.map(\.value)
        guard let mn = vals.min(), let mx = vals.max() else { return 0...1 }
        let pad = 6.0
        return (floor(mn - pad))...(ceil(mx + pad))
    }

    var targetValue: Double { 60.0 }

}
