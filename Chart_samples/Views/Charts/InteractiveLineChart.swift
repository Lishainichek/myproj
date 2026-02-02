import SwiftUI
import Charts

struct InteractiveLineChart: View {
    let data: [DataPoint]
    let yDomain: ClosedRange<Double>
    let target: Double

    @State private var selected: DataPoint?

    var body: some View {
        Chart(data) { p in
            LineMark(
                x: .value("Date", p.date),
                y: .value("Value", p.value)
            )
            RuleMark(y: .value("Target", target))
                .annotation(position: .topLeading) {
                    Text("target \(Int(target))")
                        .font(.caption)
                }

            if let s = selected {
                RuleMark(x: .value("Selected", s.date))

                PointMark(
                    x: .value("Date", s.date),
                    y: .value("Value", s.value)
                )
                .annotation(position: .top) {
                    Text("\(s.series) • \(s.value, specifier: "%.1f")")
                        .font(.caption)
                }
            }
        }
        .chartLegend(.visible)
        .chartYScale(domain: yDomain)
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 5)) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.day().month(.abbreviated))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let plotFrame = geo[proxy.plotAreaFrame]
                                let xInPlot = value.location.x - plotFrame.origin.x
                                guard xInPlot >= 0 && xInPlot <= plotFrame.size.width else { return }
                                if let date: Date = proxy.value(atX: xInPlot) {
                                    selected = nearestPoint(to: date, in: data)
                                }
                            }
                            .onEnded { _ in }
                    )
            }
        }
        .frame(height: 260)
    }

    private func nearestPoint(to date: Date, in data: [DataPoint]) -> DataPoint? {
        data.min { abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date)) }
    }
}
